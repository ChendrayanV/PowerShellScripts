$WebService = New-WebServiceProxy -uri "http://Host:Port/SM/7/IncidentManagement.wsdl"
$WebService.UseDefaultCredentials = $false
$WebService.Credentials = [System.Net.NetworkCredential]::new("UserID" , "Password")
$NameSpace = $WebService.getType().namespace
$IncidentKeysType = New-Object ($NameSpace + ".IncidentKeysType")
$IncidentInstanceType = New-Object ($NameSpace + ".IncidentInstanceType")
$IncidentModelType = New-Object ($NameSpace + ".IncidentModelType")
$IncidentModelType.instance = $IncidentInstanceType
$IncidentModelType.keys = $IncidentKeysType
$myCT = New-Object ($NameSpace + ".CreateIncidentRequest")
$myCT.model = $IncidentModelType

#region Attaching a screen shot
$Stream = [System.IO.MemoryStream]::new()
$Image = [System.Drawing.Bitmap]::new("C:\Users\ChenV\Pictures\easy.jpg")
$Image.Save($Stream,[System.Drawing.Imaging.ImageFormat]::Jpeg)
$Stream.Close()
$ImageBytes = $Stream.ToArray()

$Attachment = New-Object ($NameSpace + ".AttachmentType")
$Attachment.action = "add"
$Attachment.name = "EasyDemo.jpg"
$Attachment.len = $ImageBytes.Length
$Attachment.contentId = "attachment"
$Attachment.attachmentType = "Image/Jpeg"
$Attachment.Value = $ImageBytes
$IncidentInstanceType.attachments = $Attachment
#endregion 

#region - Status
$Status  = New-Object ($NameSpace + ".StringType")
$Status.value = "Open"
$IncidentInstanceType.Status = $Status
#endregion

#region - ReceiptMethod 
$ReceiptMethod = New-Object ($NameSpace + ".StringType")
$ReceiptMethod.value = "INTERNAL"
$IncidentInstanceType.ReceiptMethod = $ReceiptMethod
#endregion

#region - AssignmentGroup
$AssignmentGroup = New-Object ($NameSpace + ".StringType")
$AssignmentGroup.value = "US IT Support"
$IncidentInstanceType.AssignmentGroup = $AssignmentGroup
#endregion 

#region - Category
$Category = New-Object ($NameSpace + ".StringType")
$Category.Value = "incident"
$IncidentInstanceType.Category = $Category
#endregion


#region - Area
$Area = New-Object ($NameSpace + ".StringType")
$Area.value = "ChenV"
$IncidentInstanceType.Area = $Area
#endregion 

#region - SubArea
$SubArea = New-Object ($NameSpace + ".StringType")
$SubArea.value = "ChenV"
$IncidentInstanceType.Subarea = $SubArea
#endregion 

#region - Impact
$Impact  = New-Object ($NameSpace + ".StringType")
$Impact.Value = "4- Local, Limited to a single user"
$IncidentInstanceType.Impact = $Impact
#endregion

#region - Urgency
$Urgency  = New-Object ($NameSpace + ".StringType")
$Urgency.Value = "4- Normal"
$IncidentInstanceType.Urgency = $Urgency
#endregion

#region - Title
$NameSpaceitle = New-Object ($NameSpace + ".StringType")
$NameSpaceitle.Value = "Testing"
$IncidentInstanceType.Title = $NameSpaceitle
#endregion

#region - Description
$Description = New-Object ($NameSpace + ".StringType")
$Description.Value = "Created Using PowerShell"
$IncidentDescription = New-Object ($NameSpace + ".IncidentInstanceTypeDescription")
$IncidentDescription.Description = $Description
$IncidentInstanceType.Description = $IncidentDescription
#endregion

#region - Service
$Service = New-Object ($NameSpace + ".StringType")
$Service.Value = "IT IS"
$IncidentInstanceType.Service = $Service
#endregion

#region - AffectedCI
$Service  = New-Object ($NameSpace + ".StringType")
$Service.Value = "SERVER001"
$IncidentInstanceType.AffectedCI = $Service
#endregion


#region - ContactGUID
$ContactGUID  = New-Object ($NameSpace + ".StringType")
$ContactGUID.Value = "ChenV"
$IncidentInstanceType.ContactGUID = $ContactGUID
#endregion

#region - Contact
$Contact  = New-Object ($NameSpace + ".StringType")
$Contact.Value = "chendrayan.exchange@hotmail.com"
$IncidentInstanceType = $Contact
#endregion

#region - ContactLocation
$ContactLocation = New-Object ($NameSpace + ".StringType")
$ContactLocation.Value = "Tampa"
$IncidentInstanceType.ContactLocation = $ContactLocation
#endregion 

$WebService.CreateIncident($myCT).messages

$WebService.Dispose()