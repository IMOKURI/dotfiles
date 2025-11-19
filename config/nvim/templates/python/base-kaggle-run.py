import logging

import hydra
import numpy as np
import torch
from hydra.core.hydra_config import HydraConfig

import src.utils as utils

log = logging.getLogger(__name__)


@hydra.main(config_path="config", config_name="main", version_base=None)
def main(c):
    log.info("Let's go!")
    log.info(f"Params: {c.params}")

    utils.fix_seed(c.params.seed)

    run_dir = HydraConfig.get().run.dir
    log.info(f"Run dir: {run_dir}")

    np.set_printoptions(precision=3)
    torch.set_printoptions(precision=3)
    torch.set_float32_matmul_precision("medium")

    # TODO

    log.info(f"Well done. Run dir: {run_dir}")


if __name__ == "__main__":
    main()
