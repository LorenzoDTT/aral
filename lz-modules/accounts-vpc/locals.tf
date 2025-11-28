locals {
  vpc_netmask = {
    xsmall = 26,
    small  = 25,
    medium = 24,
    large  = 23,
    xlarge = 22
  }
  ipam_pool = {
    "dev" = "development",
    "pre" = "preproduction",
    "pro" = "production",
    "shr" = "sharedservices",
  }
  vpc_sizes = {
    xsmall = {
      frontend_subnets_cidrs = {
      },
      application_subnets_cidrs = {
        "az-a" = {
          cidr = cidrsubnet(data.aws_vpc.workload.cidr_block, 2, 2),
          az   = var.availability_zones[0]
        },
        "az-b" = {
          cidr = cidrsubnet(data.aws_vpc.workload.cidr_block, 2, 3),
          az   = var.availability_zones[1]
        }
      },
      data_subnets_cidrs = {
      },
      tgw_subnets_cidrs = {
        "az-a" = {
          cidr = cidrsubnet(data.aws_vpc.workload.cidr_block, 2, 0),
          az   = var.availability_zones[0]
        },
        "az-b" = {
          cidr = cidrsubnet(data.aws_vpc.workload.cidr_block, 2, 1),
          az   = var.availability_zones[1]
        }
      }
    },
    small = {
      frontend_subnets_cidrs = {
      },
      application_subnets_cidrs = {
        "az-a" = {
          cidr = cidrsubnet(data.aws_vpc.workload.cidr_block, 2, 2),
          az   = var.availability_zones[0]
        },
        "az-b" = {
          cidr = cidrsubnet(data.aws_vpc.workload.cidr_block, 2, 3),
          az   = var.availability_zones[1]
        }
      },
      data_subnets_cidrs = {
        "az-a" = {
          cidr = cidrsubnet(data.aws_vpc.workload.cidr_block, 3, 2),
          az   = var.availability_zones[0]
        },
        "az-b" = {
          cidr = cidrsubnet(data.aws_vpc.workload.cidr_block, 3, 3),
          az   = var.availability_zones[1]
        }
      },
      tgw_subnets_cidrs = {
        "az-a" = {
          cidr = cidrsubnet(data.aws_vpc.workload.cidr_block, 3, 0),
          az   = var.availability_zones[0]
        },
        "az-b" = {
          cidr = cidrsubnet(data.aws_vpc.workload.cidr_block, 3, 1),
          az   = var.availability_zones[1]
        }
      }
    },
    medium = {
      frontend_subnets_cidrs = {
        "az-a" = {
          cidr = cidrsubnet(data.aws_vpc.workload.cidr_block, 3, 2),
          az   = var.availability_zones[0]
        },
        "az-b" = {
          cidr = cidrsubnet(data.aws_vpc.workload.cidr_block, 3, 3),
          az   = var.availability_zones[1]
        }
      },
      application_subnets_cidrs = {
        "az-a" = {
          cidr = cidrsubnet(data.aws_vpc.workload.cidr_block, 2, 2),
          az   = var.availability_zones[0]
        },
        "az-b" = {
          cidr = cidrsubnet(data.aws_vpc.workload.cidr_block, 2, 3),
          az   = var.availability_zones[1]
        }
      },
      data_subnets_cidrs = {
        "az-a" = {
          cidr = cidrsubnet(data.aws_vpc.workload.cidr_block, 4, 2),
          az   = var.availability_zones[0]
        },
        "az-b" = {
          cidr = cidrsubnet(data.aws_vpc.workload.cidr_block, 4, 3),
          az   = var.availability_zones[1]
        }
      },
      tgw_subnets_cidrs = {
        "az-a" = {
          cidr = cidrsubnet(data.aws_vpc.workload.cidr_block, 4, 0),
          az   = var.availability_zones[0]
        },
        "az-b" = {
          cidr = cidrsubnet(data.aws_vpc.workload.cidr_block, 4, 1),
          az   = var.availability_zones[1]
        }
      }
    },
    large = {
      frontend_subnets_cidrs = {
        "az-a" = {
          cidr = cidrsubnet(data.aws_vpc.workload.cidr_block, 3, 1),
          az   = var.availability_zones[0]
        },
        "az-b" = {
          cidr = cidrsubnet(data.aws_vpc.workload.cidr_block, 3, 2),
          az   = var.availability_zones[1]
        }
      },
      application_subnets_cidrs = {
        "az-a" = {
          cidr = cidrsubnet(data.aws_vpc.workload.cidr_block, 2, 2),
          az   = var.availability_zones[0]
        },
        "az-b" = {
          cidr = cidrsubnet(data.aws_vpc.workload.cidr_block, 2, 3),
          az   = var.availability_zones[1]
        }
      },
      data_subnets_cidrs = {
        "az-a" = {
          cidr = cidrsubnet(data.aws_vpc.workload.cidr_block, 5, 2),
          az   = var.availability_zones[0]
        },
        "az-b" = {
          cidr = cidrsubnet(data.aws_vpc.workload.cidr_block, 5, 3),
          az   = var.availability_zones[1]
        }
      },
      tgw_subnets_cidrs = {
        "az-a" = {
          cidr = cidrsubnet(data.aws_vpc.workload.cidr_block, 5, 0),
          az   = var.availability_zones[0]
        },
        "az-b" = {
          cidr = cidrsubnet(data.aws_vpc.workload.cidr_block, 5, 1),
          az   = var.availability_zones[1]
        }
      }
    },
    xlarge = {
      frontend_subnets_cidrs = {
        "az-a" = {
          cidr = cidrsubnet(data.aws_vpc.workload.cidr_block, 3, 6),
          az   = var.availability_zones[0]
        },
        "az-b" = {
          cidr = cidrsubnet(data.aws_vpc.workload.cidr_block, 3, 7),
          az   = var.availability_zones[1]
        }
      },
      application_subnets_cidrs = {
        "az-a" = {
          cidr = cidrsubnet(data.aws_vpc.workload.cidr_block, 2, 1),
          az   = var.availability_zones[0]
        },
        "az-b" = {
          cidr = cidrsubnet(data.aws_vpc.workload.cidr_block, 2, 2),
          az   = var.availability_zones[1]
        }
      },
      data_subnets_cidrs = {
        "az-a" = {
          cidr = cidrsubnet(data.aws_vpc.workload.cidr_block, 4, 1),
          az   = var.availability_zones[0]
        },
        "az-b" = {
          cidr = cidrsubnet(data.aws_vpc.workload.cidr_block, 4, 2),
          az   = var.availability_zones[1]
        }
      },
      tgw_subnets_cidrs = {
        "az-a" = {
          cidr = cidrsubnet(data.aws_vpc.workload.cidr_block, 6, 0),
          az   = var.availability_zones[0]
        },
        "az-b" = {
          cidr = cidrsubnet(data.aws_vpc.workload.cidr_block, 6, 1),
          az   = var.availability_zones[1]
        }
      }
    }
  }
}