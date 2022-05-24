<?php
include 'dbconnection.php';
$obj = json_decode(file_get_contents('php://input'), true);


$sql = "insert into `RAW_PRODUCT`(`PRODUCT_NAME`,`QUANTITY`,`DESCRIPTION`)values('$_POST[PRODUCT_NAME]','$_POST[QUANTITY]','$_POST[DESCRIPTION]')";
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