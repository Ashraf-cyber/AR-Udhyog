<?php
include 'dbconnection.php';
$obj = json_decode(file_get_contents('php://input'), true);


$sql = "insert into `ASSIGNED_WORK`(`EMPLOYEE_NAME`,`PRODUCT_NAME`,`NUMBER_OF_ITEM`,`WORK_DESCRIPTION`)values('$_POST[EMPLOYEE_NAME]','$_POST[PRODUCT_NAME]','$_POST[NUMBER_OF_ITEM]','$_POST[WORK_DESCRIPTION]')";
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