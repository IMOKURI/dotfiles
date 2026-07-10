import argparse


def get_args():
    parser = argparse.ArgumentParser(
        description="""
        This is great script!
        """
    )

    parser.add_argument("-s", "--single-args", nargs=1, required=True, help="Help message.")
    parser.add_argument("-m", "--multiple-args", nargs="+", required=True, help="Help message.")
    parser.add_argument("-S", "--optional-single-args", nargs="?", default="default value", help="Help message.")
    parser.add_argument("-M", "--optional-multiple-args", nargs="*", default=[1, 2, 3], help="Help message.")
    parser.add_argument("-f", "--enable-flag", action="store_true", help="Help message.")

    return parser.parse_args()
