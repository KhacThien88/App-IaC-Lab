module "Appconfig"{
    source = "./AppConfig"
    providers = {
        aws = aws.region-master
    }
}