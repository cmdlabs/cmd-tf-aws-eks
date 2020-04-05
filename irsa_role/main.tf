data "aws_iam_policy_document" "federated" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type        = "Federated"
      identifiers = [var.oidc_provider_arn]
    }
    condition {
      test     = "StringEquals"
      variable = "${replace(var.oidc_provider_url, "https://", "")}:sub"
      values   = ["system:serviceaccount:${var.namespace}:${var.service_account}"]
    }
  }
}

data "aws_iam_policy_document" "main" {
  dynamic "statement" {
    for_each = var.policies
    content {
      actions   = statement.value.actions
      resources = statement.value.resources
    }
  }
}

resource "aws_iam_role" "main" {
  name               = "eks-${var.cluster_name}-${var.role_name}"
  assume_role_policy = data.aws_iam_policy_document.federated.json
}

resource aws_iam_policy "main" {
  name   = "eks-${var.cluster_name}-${var.role_name}"
  policy = data.aws_iam_policy_document.main.json
}

resource "aws_iam_role_policy_attachment" "main" {
  policy_arn = aws_iam_policy.main.arn
  role       = aws_iam_role.main.name
}
