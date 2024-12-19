from jinja2 import Environment, FileSystemLoader
from os.path import split, isfile, exists
import json
import sys


def write_latex(data: str, path: str):
    if exists(path):
        raise FileExistsError(f"File already exists: {path}")
    with open(path, mode="w") as file:
        file.write(data)

def get_template_paths(template_path: str) -> tuple[str, str]:
    if not exists(template_path) or not isfile(template_path):
        raise IOError(f"No such file or directory: '{template_path}'")
    else:
        return split(template_path)


def render_latex(data: dict, template_dir: str, template_file: str) -> str:
    env = Environment(
        loader=FileSystemLoader(template_dir),
        comment_start_string='{=',
        comment_end_string='=}',
    )
    template = env.get_template(template_file)
    return template.render(data)


def read_json(path: str) -> dict:
    with open(path) as file:
        data = json.load(file)
        return data


def main(json_path: str, template_path: str, output_path: str) -> int:
    try:
        data = read_json(json_path)
        (template_dir, template_file) = get_template_paths(template_path)
        latex = render_latex(data, template_dir, template_file)
        write_latex(latex, output_path)
        return 0
    except Exception as err:
        print(f'{err}')
        return 1

if __name__ == '__main__':
    args = sys.argv[1:]
    if len(args) < 3:
        print('Usage: python gen_cv.py DATA TEMPLATE_FILE OUTPUT')
        sys.exit(1)
    sys.exit(main(args[0], args[1], args[2]))
