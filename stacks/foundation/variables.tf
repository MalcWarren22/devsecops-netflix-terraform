# Variables file for configuration

variable "aws_region" {
  type        = string
  description = "AWS Region"
}

variable "name" {
  type        = string
  description = "Project name prefix"
  default     = "devsecops-netflix"
}

variable "env" {
  type        = string
  description = "environment name"
  default     = "dev"
}

variable "owner" {
  type        = string
  description = "Tag for the Owner"
  default     = "Hometeam"
}

variable "cost_center" {
  type        = string
  description = "Cost allocation tag"
  default     = "learning"
}

variable "monthly_budget_usd" {
  type        = string
  description = "monthly budget cost in USD"
  default     = 25
}

variable "budget_alert_email" {
  type        = string
  description = "Email that recieves budget alerts"
}