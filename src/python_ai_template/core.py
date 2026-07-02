from importlib.metadata import PackageNotFoundError
from importlib.metadata import version as distribution_version

_DISTRIBUTION_NAME = "python-ai-template"
_FALLBACK_VERSION = "0.1.0"


def version() -> str:
    try:
        return distribution_version(_DISTRIBUTION_NAME)
    except PackageNotFoundError:
        return _FALLBACK_VERSION


def normalize_label(value: str) -> str:
    return " ".join(value.split())
