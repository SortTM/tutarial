<?php
$Amount = $_GET["cost"];
$MerchantID = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxx'; 
$CallbackURL = "nitche47.infinityfreeapp.com/myzarinpal/verify.php?cost={$Amount}"; // Required
; //Amount will be based on Toman
$Authority = $_GET['Authority'];

if ($_GET['Status'] == 'OK') {

$client = new SoapClient('https://zarinpal.com/pg/services/WebGate/wsdl', ['encoding' => 'UTF-8']);

$result = $client->PaymentVerification([
	'MerchantID' => $MerchantID,
	'Authority' => $Authority,
	'Amount' => $Amount,]);

if ($result->Status == 100) {
echo 'تراکنش موفقیت آمیز بود . شمارهه پیگیری:'.$result->RefID;
$link_address = "zarinpaltest://nitche/success";
echo "<a href='$link_address'>Link</a>";
} else {
	echo 'ترانکش با خطا مواجه شد . وضعیت : '.$result->Status;
    $link_address = "zarinpaltest://nitche/failed";
	echo "<a href='$link_address'>Link</a>";
}
}else {
	echo 'عملیات پرداخت توسط کاربر لغو شد.';
    $link_address = "zarinpaltest://nitche/failed";
	echo "<a href='$link_address'>Link</a>";
}
?>
