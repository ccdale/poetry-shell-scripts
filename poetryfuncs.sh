# this file should be sourced not run
function pbump()
{
    pfn=pyproject.toml
    xlevel=${1:-"patch"}
    if currd=$(git rev-parse --show-toplevel 2>/dev/null); then
        cd $currd
        if [ -r "$pfn" ]; then
            msg=$(poetry version $xlevel)
            git add pyproject.toml
            addlock=$(git status|sed -n '/^Changes not stage/,$s/.*\(poetry.lock\).*/\1/p')
            if [ "X" != "X${addlock}" ]; then
                git add poetry.lock
            fi
            git commit -m "${msg}"
        else
            echo "$pfn not found"
        fi
    else
        echo "Cannot find git root directory"
    fi
}

function checkvenv()
{
    venv=
    if [ ! -z ${VIRTUAL_ENV} ]; then
        basename ${VIRTUAL_ENV}
    fi
}
