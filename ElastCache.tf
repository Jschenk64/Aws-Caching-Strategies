# Redis Cluster
resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "redis-cluster"
  engine               = "redis"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  security_group_ids   = [aws_security_group.cache.id]
  subnet_group_name    = aws_elasticache_subnet_group.cache.name
}

# Memcached Cluster
resource "aws_elasticache_cluster" "memcached" {
  cluster_id         = "memcached-cluster"
  engine             = "memcached"
  node_type          = "cache.t3.micro"
  num_cache_nodes    = 2
  security_group_ids = [aws_security_group.cache.id]
  subnet_group_name  = aws_elasticache_subnet_group.cache.name
}

# Subnet Group for ElastiCache
resource "aws_elasticache_subnet_group" "cache" {
  name       = "cache-subnet-group"
  subnet_ids = aws_subnet.private[*].id
}