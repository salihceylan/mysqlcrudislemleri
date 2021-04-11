
<?php
	header("Access-Control-Allow-Origin: *");
	header("Access-Control-Allow-Credentials: true");
	header("Content-type:application/json;charset=utf-8"); 
	header("Access-Control-Allow-Methods: GET");
    

    $servername = "localhost";
    $username = "flutter";
    $password = "Fingon080808Ancalime";
    $dbname = "flutter";
    $table = "Okullar"; // lets create a table named Okuls.
 
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
        

        $sql="CREATE TABLE IF NOT EXISTS $table(
            `okulKodu` INT NOT NULL , 
            `okulAdi` VARCHAR(250) CHARACTER SET utf8 COLLATE utf8_turkish_ci NOT NULL , 
            PRIMARY KEY (`okulKodu`(6))) ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_turkish_ci";

 
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
    if("TUM_OKULLARI_GETIR" == $action){
        $db_data = array();
        $sql = "SELECT * from $table ORDER BY okulKodu ASC";
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
 
    // Add an OKUL
    if("OKUL_EKLE" == $action){
        // App will be posting these values to this server
        $okulKodu = $_POST["okulKodu"];
        $okulAdi = $_POST["okulAdi"];
       

        $sql="INSERT INTO $table (`okulKodu`, `okulAdi`) VALUES ('$okulKodu', '$okulAdi')";
        $result = $conn->query($sql);
        echo "success";
        $conn->close();
        return;
    }
 
    // Remember - this is the server file.
    // I am updating the server file.
    // Update an Okul
    if("OKUL_GUNCELLE" == $action){
        // App will be posting these values to this server
        $okulKodu = $_POST['okulKodu'];
        $okulAdi = $_POST["okulAdi"];
        


        $sql = "UPDATE $table SET okulAdi = '$okulAdi' WHERE okulKodu = $okulKodu";
        if($conn->query($sql) === TRUE){
            echo "success";
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }
 
    // Delete an Okul
    if('OKUL_SIL' == $action){
        $okulKodu = $_POST['okulKodu'];
        $sql = "DELETE FROM $table WHERE okulKodu = $okulKodu"; // don't need quotes since id is an integer.
        if($conn->query($sql) === TRUE){
            echo "success";
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }
 
?>
