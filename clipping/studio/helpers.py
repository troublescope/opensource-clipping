"""
General helper utilities for Studio rendering workflow.
"""


def format_seconds(seconds):
    """
    Format a duration in seconds into HH:MM:SS.

    Args:
        seconds: Numeric duration in seconds.

    Returns:
        Duration string in `HH:MM:SS` format, clamped to non-negative.
    """
    seconds = max(0, int(seconds))
    h = seconds // 3600
    m = (seconds % 3600) // 60
    s = seconds % 60
    return f"{h:02d}:{m:02d}:{s:02d}"


def escape_ffmpeg_filter_value(value: str) -> str:
    """
    Escape a value so it is safe in FFmpeg filter expressions.

    On Windows, backslashes in paths (e.g. ``C:\\Users\\name\\file.ass``)
    are converted to forward slashes first, because FFmpeg's filter parser
    does not handle raw backslashes correctly.  Colons are then escaped
    so they are not treated as filter-option separators.

    Args:
        value: Raw value to place inside an FFmpeg filter string.

    Returns:
        Escaped value string for FFmpeg filter usage.
    """
    # Convert backslashes to forward slashes for FFmpeg compatibility.
    # This is essential on Windows where os.path.abspath returns paths
    # like 'C:\Users\name\file.ass'. FFmpeg's filter parser cannot handle
    # raw backslashes — it expects forward slashes. Doubling them (the old
    # approach) also fails because FFmpeg interprets '\\' as a literal
    # backslash in the filename, not as a path separator.
    value = str(value).replace("\\", "/")
    # Escape colons — FFmpeg uses ':' as a filter-option separator, so a
    # drive-letter colon (C:) or any colon in the path must be escaped.
    value = value.replace(":", r"\:")
    # Escape single quotes.
    value = value.replace("'", r"\'")
    return value

