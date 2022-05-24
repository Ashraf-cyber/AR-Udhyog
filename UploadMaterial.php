<?php

                    $file = $_FILES['image']['tmp_name'];
                   
                    
                  $name = round(microtime(true) * 1000) . '1.' . getFileExtension($_FILES['image']['name']);
               
                  
                    $location="";
               
                    
                    if( $_FILES["image"]["size"]>10)
                    {
                     $location = "pic/".$name;
                  
                    compressImage($_FILES['image']['tmp_name'],$location,60);
                    }
                    else
                    {
                    $location = "Nothing"; 
                    }
 include 'dbconnection.php';
 
 $sql = "INSERT INTO `UPLOAD_MATERIAL`(`MATERIAL_NAME`, `VENDOR_NAME`,`MATERIAL_QUANTITY`,`VENDOR_AMOUNT`,`CONTACT_NO`,`ADDRESS`,`PIC`) VALUES ('$_POST[MATERIAL_NAME]','$_POST[VENDOR_NAME]','$_POST[MATERIAL_QUANTITY]','$_POST[VENDOR_AMOUNT]','$_POST[CONTACT_NO]','$_POST[ADDRESS]','$location')";
   
$myObj=NULL;   
if ($con->query($sql) === TRUE) {
$myObj->message = "Query Added Successfully";
$myObj->result = "S";
} else {
     echo "Error: " . $sql . "<br>" . $con->error;
  $myObj->message = "Sorry";
$myObj->result = "F";
}

$con->close();

$myJSON = json_encode($myObj);

echo $myJSON;
 
function getFileExtension($file)
{
    $path_parts = pathinfo($file);
    return $path_parts['extension'];
}
 
 

// Compress image
function compressImage($source, $destination, $quality) {

  $info = getimagesize($source);

  if ($info['mime'] == 'image/jpeg') 
    $image = imagecreatefromjpeg($source);

  elseif ($info['mime'] == 'image/gif') 
    $image = imagecreatefromgif($source);

  elseif ($info['mime'] == 'image/png') 
    $image = imagecreatefrompng($source);

  imagejpeg($image, $destination, $quality);

}
 
 ?>