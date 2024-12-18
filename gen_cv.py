from jinja2 import Environment, FileSystemLoader
import json
import sys


def read_json(path: str) -> dict:
    with open(path) as file:
        data = json.load(file)
        return data


def main(json_path: str, template_dir: str, template_name: str, output_path: str) -> int:
    try:
        data = read_json(json_path)
        
        env = Environment(
            loader=FileSystemLoader(template_dir)
        )
        template = env.get_template(template_name)
        rendered = template.render(data)
        print(rendered)

        return 0
    except IOError as err:
        print(f"{err}")
        return 1
    except Exception as err:
        print(f"{err}")
        return 1

if __name__ == '__main__':
    args = sys.argv[1:]
    if len(args) < 4:
        print("Usage: python gen_cv.py DATA TEMPLATE_DIR TEMPLATE_FILE OUTPUT")
        sys.exit(1)
    sys.exit(main(args[0], args[1], args[2], args[3]))
