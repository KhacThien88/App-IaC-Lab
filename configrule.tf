module "config-rule"{
    source = "./AWSConfig"
    providers = {
        aws = aws.region-master
    }
}