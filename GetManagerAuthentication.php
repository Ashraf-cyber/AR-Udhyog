<?php
include 'dbconnection.php';
$obj = json_decode(file_get_contents('php://input'), true);


$sql = "SELECT * FROM `MANAGER_AUTHENTICATION` order by id DESC";
$result = $con->query($sql);
$list = array();
if ($result->num_rows > 0) 
{   
    
  while($row = $result->fetch_assoc())
  {
      $list[]=array(
          'ID' =>$row['ID'],
          'USER_ID'=> $row['USER_ID'],
          'PASSWORD'=> $row['PASSWORD']
        
          );
  }
  
  $post_data = json_encode(array('message' =>'Success','result'=>'S','data'=>$list ));
  echo $post_data;
  
}
else
{
    
$post_data = json_encode(array('message' =>'failed','result'=>'F' ));
echo $post_data;

}
$con->close();
?>