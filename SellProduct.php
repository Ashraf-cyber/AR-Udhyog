<?php
include 'dbconnection.php';
$obj = json_decode(file_get_contents('php://input'), true);


$sql = "insert into `SELL_PRODUCT`(`CUSTOMER_NAME`,`PRODUCT_NAME`,`QUANTITY`,`AMOUNT`,`DESCRIPTION`)values('$_POST[CUSTOMER_NAME]','$_POST[PRODUCT_NAME]','$_POST[QUANTITY]','$_POST[AMOUNT]','$_POST[DESCRIPTION]')";
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