#!/usr/bin/env python
import xmlrunner

__unittest = True

from unittest.main import main, TestProgram, USAGE_AS_MAIN
TestProgram.USAGE = USAGE_AS_MAIN

main(module=None, verbosity=2, testRunner=xmlrunner.XMLTestRunner(output='test-results'), failfast=False, buffer=False, catchbreak=False)
