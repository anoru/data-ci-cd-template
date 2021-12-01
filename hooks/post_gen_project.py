import os
import shutil
from pathlib import Path


project_name = "{{cookiecutter.project_slug}}"
project_name_under = "{{ cookiecutter.project_slug.replace('-', '_') }}"
project_description = "{{cookiecutter.project_description}}"
dedicated_repo = "{{cookiecutter.does_this_project_have_a_dedicated_repo}}"
environment = "default"


def replace_vars(
    path: str, is_directory: bool, project_name: str, project_description: str
):
    """
    Replace variables in files.

    :path: file or directory path
    :is_directory: bool indicate if the path is for a file or for a directory
    :project_name: name of the project
    :project_description: description of the project
    """

    _path = Path(path).rglob("*")

    if is_directory:
        for child in _path:
            if child.is_file() and (child.suffix not in [".json", ".whl"]):

                content = (
                    child.read_text()
                    .replace("{project_slug}", project_name)
                    .replace("{project_slug_under}", project_name_under)
                )

                child.write_text(content)

    else:
        content = (
            _path.read_text()
            .replace("{project_slug}", project_name)
            .replace("{project_slug_under}", project_name_under)
        )

        _path.write_text(content)


class PostProcessor:
    @staticmethod
    def process():

        # Replace variables that has conflict with cookiecutter
        replace_vars(
            path=".",
            is_directory=True,
            project_name=project_name,
            project_description=project_description,
        )

        # Initiate git if the project has its own repo
        if dedicated_repo == "Yes":
            os.system(f"cd {project_name}")
            os.system("git init")
            os.system("git add .")
            os.system("git commit -m 'init: first commit from the template'")
            os.system("git branch -M main")

            print(
                "---------------------------------------------------------------------------------"
            )
            print("Few steps and you are all setup")
            print("\n1- Change to the project directory")
            print(f"cd {project_name}")

            print("\n2- Please refer to your repository page to get the <Repo Link>")
            print(
                "Excute the cmd bellow to create a new connection record to your remote repository"
            )
            print("git remote add origin <Repo Link>")
            print("ie: git remote add origin https://github.com/Talend/...")

            print("\n3- push the code to the main branch")
            print("git push -u origin main")

            print("\n4- Create a new branch and get your nails dirty with some code")

            print("\n\nWOOHOO!! You are all setup.")
            print(
                "---------------------------------------------------------------------------------"
            )
        else:
            print("WOOHOO!! You are all setup.")


if __name__ == "__main__":
    post_processor = PostProcessor()
    post_processor.process()
