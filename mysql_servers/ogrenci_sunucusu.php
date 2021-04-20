<?php
	header("Access-Control-Allow-Origin: *");
	header("Access-Control-Allow-Credentials: true");
	header("Content-type:application/json;charset=utf-8"); 
	header("Access-Control-Allow-Methods: GET");
    

    $servername = "localhost";
    $username = "flutter";
    $password = "Fingon080808Ancalime";
    $dbname = "flutter";
    $table = "Ogrenciler"; // lets create a table named Ogrencis.
 
    // we will get actions from the app to do operations in the database...

    //action : yapılacak iş.....
    $action = $_POST["action"];
     
    // Create Connection
    $conn = new mysqli($servername, $username, $password, $dbname);
    // Check Connection
    if($conn->connect_error){
        die("Connection Failed: " . $conn->connect_error);
        return;
    }
 
    // If connection is OK...
 
    // If the app sends an action to create the table...
    if("TABLO_OLUSTUR" == $action){
        $sql = "CREATE TABLE IF NOT EXISTS $table(
            `ogrenci_no` INT NOT NULL AUTO_INCREMENT,
            `adi_soyadi` VARCHAR(45) NULL,
            `tc_kimlik_no` VARCHAR(45) NULL,
            `dogum_tarihi` VARCHAR(10) NULL,
            PRIMARY KEY (`ogrenci_no`))";

 
        if($conn->query($sql) === TRUE){
            // send back success message
            echo "success";
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }
 
    // Get all employee records from the database
    if("TUM_OGRENCILERI_GETIR" == $action){
        $db_data = array();
        $sql = "SELECT * from $table ORDER BY ogrenci_no ASC";
        $result = $conn->query($sql);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }
            // Send back the complete records as a json
            echo json_encode($db_data);
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }
 
    // Add an Ogrenci
    if("OGRENCI_EKLE" == $action){
        // App will be posting these values to this server
        $adi_soyadi = $_POST["adi_soyadi"];
        $tc_kimlik_no = $_POST["tc_kimlik_no"];
        $dogum_tarihi = $_POST["dogum_tarihi"];

        $sql="INSERT INTO $table (adi_soyadi, tc_kimlik_no, dogum_tarihi) VALUES ('$adi_soyadi', '$tc_kimlik_no', '$dogum_tarihi')";
        $result = $conn->query($sql);
        echo "success";
        $conn->close();
        return;
    }
 
    // Remember - this is the server file.
    // I am updating the server file.
    // Update an Ogrenci
    if("OGRENCI_GUNCELLE" == $action){
        // App will be posting these values to this server
        $ogrenci_no = (int)$_POST["ogrenci_no"];
        $adi_soyadi = $_POST["adi_soyadi"];
        $tc_kimlik_no = $_POST["tc_kimlik_no"];
        $dogum_tarihi =$_POST["dogum_tarihi"];


        $sql = "UPDATE $table SET adi_soyadi = '$adi_soyadi', tc_kimlik_no = '$tc_kimlik_no', dogum_tarihi= $dogum_tarihi WHERE ogrenci_no = $ogrenci_no";
        if($conn->query($sql) === TRUE){
            echo "success";
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }
 
    // Delete an Ogrenci
    if('OGRENCI_SIL' == $action){
        $ogrenci_no = $_POST['ogrenci_no'];
        $sql = "DELETE FROM $table WHERE ogrenci_no = $ogrenci_no"; // don't need quotes since id is an integer.
        if($conn->query($sql) === TRUE){
            echo "success";
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }
 
?>
