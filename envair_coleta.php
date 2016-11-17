<?php
$my_domain = "jertransportes.com.br";

if ($_POST['coleta-honey'] === '') {
	$remetente = $_POST['remetente'];
	$remcnpj = $_POST['remcnpj'];
	$remendereco = $_POST['remendereco'];
	$remmunicipio = $_POST['remmunicipio'];
	$destinatario = $_POST['destinatario'];
	$destcnpj = $_POST['destcnpj'];
	$destendereco = $_POST['destendereco'];
	$destmunicipio = $_POST['destmunicipio'];
	$natureza = $_POST['natureza'];
	$notasfiscais = $_POST['notasfiscais'];
	$valores = $_POST['valores'];
	$kg = $_POST['kg'];
	$lt = $_POST['lt'];
	$obs = $_POST['obs'];

	$email_remetente = "contato@jertransportes.com.br"; // deve ser uma conta de email do seu dominio
	$email_destinatario = "contato@jertransportes.com.br"; // pode ser qualquer email que receberá as mensagens
	$email_reply = "$email_remetente";
	$email_assunto = "Solicitação de coleta: $remetente"; // Este será o assunto da mensagem

	//Monta o Corpo da Mensagem
	$email_conteudo .= "\n=== Remetente ===\n\n$remetente \n";
	$email_conteudo .= "CNPJ: $remcnpj \n";
	$email_conteudo .= "Endereço: $remendereco \n";
	$email_conteudo .= "Município: $remmunicipio \n";
	$email_conteudo .= "\n=== Destinatário ===\n\n$destinatario \n";
	$email_conteudo .= "CNPJ: $destcnpj \n";
	$email_conteudo .= "Endereço: $destendereco \n";
	$email_conteudo .= "Município: $destmunicipio \n";
	$email_conteudo .= "\n=== Carga ===\n\n";
	$email_conteudo .= "Natureza: $natureza \n";
	$email_conteudo .= "Notas fiscais: $notasfiscais \n";
	$email_conteudo .= "Valores: $valores \n";
	$email_conteudo .= "Kg: $kg \n";
	$email_conteudo .= "Lt: $lt \n";
	$email_conteudo .= "\n=== Observação ===\n\n";
	$email_conteudo .= "$obs";

	//Seta os Headers (Alterar somente caso necessario)
	$email_headers = implode ( "\n",array ( "From: $email_remetente", "Reply-To: $email_reply", "Return-Path: $email_remetente","MIME-Version: 1.0","X-Priority: 3","Content-Type: text/html; charset=UTF-8" ) );

	//Enviando o email
	if (mail ($email_destinatario, $email_assunto, nl2br($email_conteudo), $email_headers)){
		header('Location: http://' . $my_domain . '/envio_sucesso.html');
		exit('email enviado');
	}
	else{
		header('Location: http://' . $my_domain . '/envio_com_erro.html');
		exit('email com erro');
	}
}
else {
	header('Location: http://' . $my_domain . '/envio_incompleto.html');
	exit('dados faltando');
}
?>