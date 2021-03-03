<?php

$Amount = $_GET["cost"];
$MerchantID = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxx';  //Required
$CallbackURL = "http://nitche47.infinityfreeapp.com/myzarinpal/verify.php?cost={$Amount}"; // Required
$Description = 'توضیحات تراکنش'; // Required
$Email = 'U'; // Optional
$Mobile = ''; // Optional

$client = new SoapClient('https://zarinpal.com/pg/services/WebGate/wsdl', ['encoding' => 'UTF-8']);

$result = $client->PaymentRequest([
	'MerchantID' => $MerchantID,
	'Amount' => $Amount,
	'Description' => $Description,
	'Email' => $Email,
	'Mobile' => $Mobile,
	'CallbackURL' => $CallbackURL,]);

//Redirect to URL You can do it also by creating a form
if ($result->Status == 100) {
Header('Location: https://zarinpal.com/pg/StartPay/'.$result->Authority);
} else {
    echo "خطا در ایجاد تراکنش";
	echo "<br />کد خطا : ". $result["Status"];
	echo "<br />تفسیر و علت خطا : ". $result["Message"];
	$link_address = "zarinpaltest://nitche/failed";
	echo "<a href='$link_address'>Link</a>";
}
?>