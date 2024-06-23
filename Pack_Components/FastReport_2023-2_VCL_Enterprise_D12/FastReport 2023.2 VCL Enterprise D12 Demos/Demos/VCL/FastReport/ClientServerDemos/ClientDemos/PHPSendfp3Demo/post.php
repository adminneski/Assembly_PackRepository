<?php
$host ='http://localhost:8097';//FR server address
$exportFormat = 'PDF';//export format //'PDF'/'ODS'/'ODT'/'XML'/'XLS'/'RTF'/'TXT'/'CSV'/'JPG'/'BMP'/'GIF'/'TIFF'

$OldName = $_FILES['userfile']['name'];//The name of the file that the user sent us
$name = substr_replace($_FILES['userfile']['tmp_name'], 'fp3', -3);//Its actual name after our download (replace the .tmp extension with .fp3)
move_uploaded_file($_FILES['userfile']['tmp_name'], $name);//Save on php server
$file = new \CURLFile($name);//Open
$ch = curl_init();

curl_setopt($ch, CURLOPT_URL, $host);
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);//To read the returned data.
curl_setopt($ch, CURLOPT_HEADER, 1);//To read the returned header
curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 0);//for large files, you need to increase the default wait (30 seconds), set 0 = infinite

//=======================================
//To prevent the FR server from accepting files that it already has.
//Generating MD5 for the string and sending the format.
$md5 = md5_file($name);
curl_setopt($ch, CURLOPT_HTTPHEADER , array('Format-Export: '.$exportFormat, 'Content-MD5: '.$md5));
//=======================================
$data = array($exportFormat => $file); 
curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
$response = curl_exec($ch);

//Debug checkback
if (empty($response))
{
	echo 'received an empty response';
}
else
{
	if (strstr($response, 'HTTP/1.1 301') == '')
	{
			echo '404';//Something went wrong. The server returned an unexpected response
			curl_close($ch);
		    exit;
	}
	if (curl_errno($ch))
	{
		echo '<span style="color:red">';
		echo 'error: '.curl_error($ch);
		echo '</span>';
	}
	else
	{
		$Location = GetLocationFromHeader($response);//We extract the address from the response of the FR server to receive the export results
		if (empty($Location))
		{
			echo 'error: Location not found';
		}
		else
		{
            //You can direct the client to the address to receive the file, but not in the architecture where the fr-server is connected to the php-server locally and the FR-server does not have access to the Internet.
            //You will have to download everything using the php server.
            //And it is safer from the point of view of logic, so that the pests do not climb on other people's documents in the cache of the FR server.
			$file = file_get_contents_curl($host.$Location);
			if (empty($file))
			{
				echo 'error: file missing';
			}
			{
				//We need to generate a new name to serve the file to the client.
				//Here it is implemented as follows: File name = as it was with the client, and the server response is parsed to get the extension.
				//You can lowercase $exportFormat, but this is not relevant for all exports
				//And you can store some array nearby.
				//P.S. the name can be taken, for example, from the server response, and then it will be equal to the MD5 hash, even if it was not generated in php
				//For this $FileName = GetFileNameFromLocation($Location); 
				
				$Format = getExtension(GetFileNameFromLocation($Location)); //Extract the format from the response
				$OldName = substr_replace($OldName, $Format, -3);//We take the old name that the client sent us and replace the extension with the export result (if he sent 123.fp3, we will get 123.pdf)
				
				header('X-Accel-Redirect: storage/'.$OldName);
				header('Content-Disposition: attachment; filename="'.$OldName.'"');
				
				echo $file;
			}
		}
	}
}
curl_close($ch);



//secondary functions
function GetLocationFromHeader($arg_1)	//extracts the address from the server response to get the conversion result
{
	$Location = strstr($arg_1, 'Location');
	$Location = strstr($Location, '/');
	$Location = substr($Location, 0, strrpos($Location, 'SessionId')-2);
    return $Location;
}

function GetFileNameFromLocation($arg_1)	//Filename from response
{
	$FN = substr($arg_1, strripos($arg_1, '/')+1, strlen($arg_1));
    return $FN;
}

function getExtension($fileName) //Extension from file name
{
	return substr($fileName, strrpos($fileName, '.') + 1);
}

function file_get_contents_curl($url)	//analog of the file_get_contents function... faster?
{
    $ch = curl_init();

    curl_setopt($ch, CURLOPT_AUTOREFERER, TRUE);
    curl_setopt($ch, CURLOPT_HEADER, 0);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, TRUE);       

    $data = curl_exec($ch);
    curl_close($ch);

    return $data;
}
?>