<?php

                    $file = $_FILES['image']['tmp_name'];
                    $file2 = $_FILES['image2']['tmp_name'];
                    
                   
                    
                  $name = round(microtime(true) * 1000) . '1.' . getFileExtension($_FILES['image']['name']);
                  $name2 = round(microtime(true) * 1000) . '1.' . getFileExtension($_FILES['image2']['name']);
               
                  
                    $location1="";
                    $location2="";
                    
               
                    
                    if( $_FILES["image"]["size"]>10)
                    {
                          $location1 = "pic/".$name;
                     $location2 = "AdhaarImage/".$name2;
                   
                     
                  
                    compressImage($_FILES['image']['tmp_name'],$location1,60);
                    
                    compressImage($_FILES['image2']['tmp_name'],$location2,60);
                    }
                    else
                    {
                    $location1 = "Nothing"; 
                      $location2 = "Nothing"; 
                    }
                    
                    
                    
                    
 include 'dbconnection.php';
 
 
$sql = "INSERT INTO `ADD_EMPLOYEE`(`EMPLOYEE_NAME`,`PASSWORD`,`CONTACT`,`ADDRESS`,`EMPLOYEE_TYPE`,`DAY_CHARGE`,`PIC`,`AADHAAR_PIC`) VALUES ('$_POST[EMPLOYEE_NAME]','$_POST[PASSWORD]','$_POST[CONTACT]','$_POST[ADDRESS]','$_POST[EMPLOYEE_TYPE]','$_POST[DAY_CHARGE]','$location1','$location2')";
   
$myObj=NULL;   
if ($con->query($sql) === TRUE) {
$myObj->user_name = $_POST['user_name'];    
$myObj->message = "Query Added Successfully";
$myObj->result = "S";
} else {
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