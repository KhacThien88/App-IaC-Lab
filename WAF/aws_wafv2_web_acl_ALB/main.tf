resource "aws_wafv2_web_acl" "alb_waf" {
  name        = "alb-waf"
  description = "WAF for ALB"
  scope       = "REGIONAL"

  default_action {
    allow {}
  }

  rule {
    name     = "common-rule-set"
    priority = 1

    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"

        rule_action_override {
          name = "SizeRestrictions_QUERYSTRING"
          action_to_use {
            count {}
          }
        }

        rule_action_override {
          name = "NoUserAgent_HEADER"
          action_to_use {
            count {}
          }
        }

        scope_down_statement {
          geo_match_statement {
            country_codes = ["VN", "US"]
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "commonRuleSetALB"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "exampleWAFALB"
    sampled_requests_enabled   = true
  }

  tags = {
    Environment = "production"
    Application = "alb"
  }
}

resource "aws_wafv2_web_acl_association" "alb_waf_association" {
  resource_arn = var.alb-arn
  web_acl_arn  = aws_wafv2_web_acl.alb_waf.arn
}
