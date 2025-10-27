#!/usr/bin/env python3
"""
Tests for Hello World Script
"""

import sys
import os
from io import StringIO

# Add src directory to path
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', 'src'))

from hello_world import main


def test_hello_world_output():
    """Test that main() prints 'Hello, World!'"""
    # Capture stdout
    captured_output = StringIO()
    sys.stdout = captured_output

    # Run main function
    main()

    # Reset stdout
    sys.stdout = sys.__stdout__

    # Check output
    assert captured_output.getvalue().strip() == "Hello, World!"


if __name__ == "__main__":
    test_hello_world_output()
    print("All tests passed!")
