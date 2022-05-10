<?php
include 'dbconnection.php';
$obj = json_decode(file_get_contents('php://input'), true);


$sql = "insert into `DEVICE_INFO`(`BRAND`,`BOARD`,`ANDROID_ID`,`DEVICE`,`HARDWARE`,`MODEL`,`ANDROID_VER_ID`,`TOKEN`,`TYPE`,`MANUFACTURE`,`HOST`,`IS_PHYSICAL_DEVICE`)values('$obj[BRAND]','$obj[BOARD]','$obj[ANDROID_ID]','$obj[DEVICE]','$obj[HARDWARE]','$obj[MODEL]','$obj[ANDROID_VER_ID]','$obj[TOKEN]','$obj[TYPE]','$obj[MANUFACTURE]','$obj[HOST]','$obj[IS_PHYSICAL_DEVICE]')";
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