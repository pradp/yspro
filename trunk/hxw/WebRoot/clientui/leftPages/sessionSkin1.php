<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<?php
session_start();
$_SESSION['skinName1']=$_GET["skinName"];
$_SESSION['themeColor1']=$_GET["themeColor"];
?>
<script>
window.onload=function(){
	top.window.location.reload();
}
</script>
<body>
</body>
</html>

