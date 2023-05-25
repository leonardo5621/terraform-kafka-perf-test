resource "helm_release" "strimzi" {
  name       = "strimzi"
  namespace = "strimzi"
  
  repository = "https://strimzi.io/charts"
  chart      = "strimzi-kafka-operator"

  set {
    name = "watchNamespaces"
    value = "{application}"
  }

  depends_on = [kubernetes_namespace.strimzi]
}