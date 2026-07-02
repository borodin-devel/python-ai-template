from importlib.metadata import PackageNotFoundError

from hypothesis import given
from hypothesis import strategies as st

from python_ai_template import core, normalize_label, version
from python_ai_template.cli import main


def test_version_returns_non_empty_string() -> None:
    assert version()


def test_version_falls_back_when_distribution_metadata_is_missing(monkeypatch) -> None:
    def raise_missing_distribution(_: str) -> str:
        raise PackageNotFoundError

    monkeypatch.setattr(core, "distribution_version", raise_missing_distribution)

    assert core.version() == "0.1.0"


def test_cli_prints_version(capsys, monkeypatch) -> None:
    monkeypatch.setattr("python_ai_template.cli.version", lambda: "9.9.9")

    main()

    assert capsys.readouterr().out == "python_ai_template 9.9.9\n"


@given(st.text())
def test_normalize_label_is_idempotent(value: str) -> None:
    normalized = normalize_label(value)

    assert normalize_label(normalized) == normalized


@given(st.text())
def test_normalize_label_removes_outer_whitespace(value: str) -> None:
    normalized = normalize_label(value)

    assert normalized == normalized.strip()
