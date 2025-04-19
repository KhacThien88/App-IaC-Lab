resource "aws_wafv2_web_acl" "cloudfront_waf" {
  name        = "cloudfront-waf-acl"
  description = "WAF for existing CloudFront distribution"
  scope       = "CLOUDFRONT"

  default_action {
    allow {}
  }

  rule {
    name     = "block-sql-injection"
    priority = 1

    action {
      block {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesSQLiRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "blockSQLInjection"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rate-limit"
    priority = 2

    action {
      block {}
    }

    statement {
      rate_based_statement {
        limit              = 2000
        aggregate_key_type = "IP"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "rateLimit"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "cloudfrontWAF"
    sampled_requests_enabled   = true
  }
}
