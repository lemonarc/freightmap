<%
'Initialize variables:
Dim vBT, i, vIP, vReferer

'Gather some interesting information:
vIP = Request.ServerVariables("REMOTE_ADDR")
vReferer = Request.ServerVariables("HTTP_REFERER")

'Start the e-mail message with an introductory header:
vBT = "Results of form " & vReferer & " posted by" & vbCrLf & vIP & " at " & Time & " on " & Date & ":" & vbCrLf & vbCrLf

'Loop through the fields in the posted form, creating the e-mail message:
For i = 1 To Request.Form.Count
	If Request.Form.Key(i) <> "x" And Request.Form.Key(i) <> "y" And Request.Form.Key(i) <> "submit" And _
	Request.Form.Key(i) <> "recipientname" And Request.Form.Key(i) <> "recipientemail" And Request.Form.Key(i) <> "redirect" Then
		vBT = vBT & Request.Form.Key(i) & " - " & Request.Form.Item(i) & vbCrLf
	End If
Next

If Instr( UCase( Request.Form("fullname") ), "CONTENT-TYPE:" ) > 0 or _
   Instr( UCase( Request.Form("fullname") ), "MIME-VERSION:" ) > 0 or _
   Instr( UCase( Request.Form("fullname") ), "BCC:"          ) > 0 or _ 
   Instr( UCase( Request.Form("email"   ) ), "CONTENT-TYPE:" ) > 0 or _
   Instr( UCase( Request.Form("email"   ) ), "MIME-VERSION:" ) > 0 or _
   Instr( UCase( Request.Form("email"   ) ), "BCC:"          ) > 0 or _    
   Instr( UCase( Request.Form("subject" ) ), "CONTENT-TYPE:" ) > 0 or _
   Instr( UCase( Request.Form("subject" ) ), "MIME-VERSION:" ) > 0 or _
   Instr( UCase( Request.Form("subject" ) ), "BCC:"          ) > 0 or _    
   Instr( UCase( vBT                      ), "CONTENT-TYPE:" ) > 0 or _
   Instr( UCase( vBT                      ), "MIME-VERSION:" ) > 0 or _
   Instr( UCase( vBT                      ), "BCC:"          ) > 0 then
   Response.Redirect("contact_fail.html")
Else   
   'Mail to the recipient:
   Set Mailer = Server.CreateObject("SMTPsvg.Mailer")
   If Request.Form("fullname") = "" Then
   	Mailer.FromName = "Unknown"
   Else
   	Mailer.FromName = Request.Form("fullname")
   End If
   If Request.Form("email") = "" Then
   	Mailer.FromAddress = "unknown@unknown.com"
   Else
   	Mailer.FromAddress = Request.Form("email")
   End If
   Mailer.RemoteHost = "smtp.sys3internet.net"
   Mailer.AddRecipient "FreightMap", "info@freightmap.com"
   If Request.Form("subject") = "" Then
   	Mailer.Subject = "Online Form Results"
   Else
   	Mailer.Subject = Request.Form("subject")
   End If
   Mailer.BodyText = vBt
   If Mailer.Sendmail Then
   '	If Request.Form("redirect") = "" Then
   '		Response.Redirect vReferer
   '	Else
   '		Response.Redirect Request.Form("redirect")
   '	End If
      Response.Redirect("contact_success.html")
   Else
      Response.Redirect("contact_fail.html")
   End If
End If   
%>
