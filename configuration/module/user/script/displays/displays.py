import json
import subprocess

result = subprocess.run(["wlr-randr", "--json"], stdout=subprocess.PIPE)
if result.returncode == 0:
    data = json.loads(result.stdout)
    print(data)
