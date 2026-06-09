# Tworzenie instancji w chmurze (AWS) dla Zadania 10
# Ważne: Wykorzystujemy t3.micro, które jest dostępne w darmowej warstwie (Free Tier) w regionie eu-north-1.

Write-Host "Pobieranie domyślnego VPC..."
$VpcId = aws ec2 describe-vpcs --query "Vpcs[0].VpcId" --output text

Write-Host "Pobieranie domyślnej podsieci..."
$SubnetId = aws ec2 describe-subnets --filters "Name=vpc-id,Values=$VpcId" --query "Subnets[0].SubnetId" --output text

Write-Host "Tworzenie Security Group 'Zadanie10-SG'..."
$GroupId = aws ec2 create-security-group --group-name "Zadanie10-SG" --description "Security Group dla serwera aplikacji Zadanie 10" --vpc-id $VpcId --query "GroupId" --output text

if ($GroupId -eq "" -or $GroupId -match "InvalidGroup.Duplicate" -or $null -eq $GroupId) {
    Write-Host "Security Group już istnieje. Pobieranie jej ID..."
    $GroupId = aws ec2 describe-security-groups --group-names "Zadanie10-SG" --query "SecurityGroups[0].GroupId" --output text
} else {
    Write-Host "Otwieranie portów: 22 (SSH), 80 (Frontend), 8080 (Backend), 3000 (React Dev)..."
    aws ec2 authorize-security-group-ingress --group-id $GroupId --protocol tcp --port 22 --cidr 0.0.0.0/0 | Out-Null
    aws ec2 authorize-security-group-ingress --group-id $GroupId --protocol tcp --port 80 --cidr 0.0.0.0/0 | Out-Null
    aws ec2 authorize-security-group-ingress --group-id $GroupId --protocol tcp --port 8080 --cidr 0.0.0.0/0 | Out-Null
    aws ec2 authorize-security-group-ingress --group-id $GroupId --protocol tcp --port 3000 --cidr 0.0.0.0/0 | Out-Null
}

Write-Host "Tworzenie klucza SSH 'Zadanie10Key'..."
aws ec2 delete-key-pair --key-name Zadanie10Key | Out-Null
aws ec2 create-key-pair --key-name Zadanie10Key --query "KeyMaterial" --output text > Zadanie10Key.pem
Write-Host "Klucz SSH został zapisany w pliku Zadanie10Key.pem"

Write-Host "Znajdowanie najnowszego obrazu Ubuntu 22.04 LTS..."
$AmiId = aws ec2 describe-images --owners amazon --filters "Name=name,Values=ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*" "Name=state,Values=available" --query "sort_by(Images, &CreationDate)[-1].ImageId" --output text

Write-Host "Uruchamianie darmowej instancji t3.micro..."
$InstanceId = aws ec2 run-instances `
    --image-id $AmiId `
    --count 1 `
    --instance-type t3.micro `
    --key-name Zadanie10Key `
    --security-group-ids $GroupId `
    --subnet-id $SubnetId `
    --user-data file://user-data.sh `
    --query "Instances[0].InstanceId" `
    --output text

Write-Host "Instancja $InstanceId została pomyślnie uruchomiona! (Instalacja Dockera w tle zajmie ok. 1-2 minuty)"

Write-Host "Oczekiwanie na publiczny adres IP..."
Start-Sleep -Seconds 10
$PublicIp = aws ec2 describe-instances --instance-ids $InstanceId --query "Reservations[0].Instances[0].PublicIpAddress" --output text

Write-Host ""
Write-Host "================================================="
Write-Host "Gotowe! Twój serwer jest uruchomiony na chmurze AWS."
Write-Host "Publiczne IP: $PublicIp"
Write-Host "Możesz się z nim połączyć przez SSH:"
Write-Host "ssh -i Zadanie10Key.pem ubuntu@$PublicIp"
Write-Host "================================================="
