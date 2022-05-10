<?php
include 'dbconnection.php';
$obj = json_decode(file_get_contents('php://input'), true);


$sql = "insert into `ADD_MATERIAL`(`MATERIAL_NAME`,`MATERIAL_UNIT`)values('$_POST[MATERIAL_NAME]','$_POST[MATERIAL_UNIT]')";
// $conn->query($sql);
if ($con->query($sql)==TRUE) 
{
$post_data = json_encode(array('message' =>'Success','result'=>'S' ));
echo $post_data;
}
else
{
    echo "Error: " . $sql . "<br>" . mysqli_error($con);

$post_data = json_encode(array('message' =>'failed','result'=>'F' ));
echo $post_data;

}
$con->close();
?>