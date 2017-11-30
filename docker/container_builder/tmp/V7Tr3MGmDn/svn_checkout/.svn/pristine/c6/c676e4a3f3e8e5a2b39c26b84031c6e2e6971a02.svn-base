from settings import *

import sys, unittest, string
import json
import time
import urllib, urllib2
import re #to use regular expression
from random import randint
from collections import Counter

from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import Select
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import NoSuchElementException, TimeoutException


class SeleniumBrowserTestCase(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        cls.browser = webdriver.Remote(
            command_executor='http://selenium:4444/wd/hub',
            desired_capabilities={
                'browserName': 'chrome',
                'javascriptEnabled': True,
                'loggingPrefs' : { 'browser':'ALL' }
            }
        )

    def __init__(self, *args, **kwargs):
        super(SeleniumBrowserTestCase, self).__init__(*args, **kwargs)
        self.baseurl = baseurl

    @classmethod
    def authenticate(cls, browser, username, password):
        # Go to login page (even if currently authenticated)
        browser.get(baseurl)

        browser.find_element_by_css_selector('input[name="SD_Login_Username"]').send_keys(username)
        browser.find_element_by_css_selector('input[name="SD_Login_Password"]').send_keys(password)

        # Find the Sign In button in the form
        browser.find_element_by_css_selector('input[type="submit"]').click()

        # wait for auth models to populate
	time.sleep(sleepSeconds)

    def waitForElementToAppear(self, selector, waitTime = 5):
        WebDriverWait(self.browser, waitTime).until(
            EC.presence_of_element_located((By.CSS_SELECTOR, selector))
        )

    def checkMandatory(self):
        # check for mandatory fields
        mandatory_fields = self.browser.find_elements_by_css_selector('.fa-asterisk')

        # click next button
        self.browser.find_element_by_css_selector(button["next"]).click()
        time.sleep(1)

        errors = self.browser.find_elements_by_css_selector('.error[role="alert"]')

        # check if numb of mandatory fields are equal to error alerts
        # we substract 1 from error alert because 1st error is a generic error
        self.assertEqual( len(mandatory_fields), len(errors)-1 )

    def getNumbOfQuestionsAndItsTypes(self):
        types = {}

        question_types = {
            "single_or_multiple_choice_or_rank" : "fieldset.question-legend",
            "multi_textbox_table"               : "p strong",
            "int"                               : ".align-labels label + input",
            "scale"                             : ".scale",
        }

        for name, selector in question_types.iteritems():
            try:
                elements = self.browser.find_elements_by_css_selector(selector)

                if(name == "single_or_multiple_choice_or_rank"):
                    sc_type   = 0
                    mc_type   = 0
                    rank_type = 0

                    que_types = {
                        "sc"    : 'fieldset input[type="radio"]',
                        "mc"    : 'fieldset input[type="checkbox"]',
                        "rank"  : '.fieldset-content .align-labels label',
                    }

                    # Check which type of questions exist
                    for que_name, que_selector in que_types.iteritems():
                        try:
                            # check if sc type questions exist
                            self.browser.find_element_by_css_selector(que_selector)
                            if(que_name == "sc"):
                                sc_type = 1
                            elif(que_name == "mc"):
                                mc_type = 1
                            else:
                                rank_type = 1

                        except NoSuchElementException as e:
                            self.assertTrue(True)

                    # Now, depending on the above output, find number of each que type
                    ## Case1 : All three types present ##
                    # if (sc_type == 1) and (mc_type == 1) and (rank_type == 1) :


                    ## Case2 : Two of the types present ##
                    if (sc_type == 1) and (mc_type == 1) and (rank_type == 0) :
                        total_questions = self.browser.find_elements_by_css_selector('fieldset ul.choice_v')
                        types.update({'total_single_and_multiple_choice': len(total_questions)})

                    # if (sc_type == 0) and (mc_type == 1) and (rank_type == 1) :

                    if (sc_type == 1) and (mc_type == 0) and (rank_type == 1) :
                        sc_questions = self.browser.find_elements_by_css_selector('fieldset ul.choice_v')
                        types.update({'single_choice': len(sc_questions)})

                        rank = self.browser.find_elements_by_css_selector('fieldset.question-legend')
                        types.update({'estimated_rank_type_questions': len(rank)})

                    ## Case3 : Only one of the types present ##
                    if (sc_type == 1) and (mc_type == 0) and (rank_type == 0) :
                        sc_questions = self.browser.find_elements_by_css_selector('fieldset ul.choice_v')
                        if (len(sc_questions) != 0):
                            types.update({'single_choice': len(sc_questions)})

                    if (sc_type == 0) and (mc_type == 1) and (rank_type == 0) :
                        mc_questions = self.browser.find_elements_by_css_selector('fieldset ul.choice_v')
                        types.update({'multiple_choice': len(mc_questions)})

                    if (sc_type == 0) and (mc_type == 0) and (rank_type == 1) :
                        rank_questions = self.browser.find_elements_by_css_selector('fieldset.question-legend')
                        types.update({'rank': len(rank_questions)})


                    # try:
                    #     # first check if both sc and mc type questions exist
                    #     self.browser.find_element_by_css_selector('fieldset input[type="radio"]')
                    #     self.browser.find_element_by_css_selector('fieldset input[type="checkbox"]')
                    #
                    #     total_questions = self.browser.find_elements_by_css_selector('fieldset ul.choice_v')
                    #
                    #     types.update({'total_single_and_multiple_choice': len(total_questions)})
                    #
                    # except AssertionError as e:
                    #     try:
                    #         self.browser.find_elements_by_css_selector('fieldset input[type="radio"]')
                    #         sc_questions = self.browser.find_elements_by_css_selector('fieldset ul.choice_v')
                    #         types.update({'single_choice': len(sc_questions)})
                    #
                    #     except AssertionError as e:
                    #         self.browser.find_elements_by_css_selector('fieldset input[type="checkbox"]')
                    #         mc_questions = self.browser.find_elements_by_css_selector('fieldset ul.choice_v')
                    #         types.update({'multiple_choice': len(mc_questions)})

                if(name == "multi_textbox_table"):
                    total_found = len(elements)

                    try:
                        unwanted_ele = len(self.assertElementsExist('p strong u'))
                    except AssertionError as e:
                        unwanted_ele = 0

                    ele_wanted = total_found - unwanted_ele

                    if (ele_wanted - 1) != 0 :
                        types.update({name : ele_wanted-1})

                if(name == "int"):
                    for element in elements:
                        if element.is_displayed():
                            self.assertTrue(True)
                        else:
                            elements.remove(element)

                    if len(elements) != 0:
                        types.update({name : len(elements)})

                if (name == "scale"):
                    if (len(elements)) != 0 :
                        types.update({name : len(elements)})

            except Exception as e:
                # print e
                self.assertTrue(True)

        return types

    def fillForm(self, valid = True):
        types = self.getNumbOfQuestionsAndItsTypes()
        print types

        for que_type, numbr in types.iteritems():
            if valid:
                if que_type == "single_choice":
                    for i in range(1, numbr+1):
                        # choose the first option for each que
                        self.browser.find_element_by_css_selector('fieldset:nth-of-type(' + str(i) +') ul li label').click()

                if que_type == "multiple_choice":
                    for i in range(1, numbr+1):
                        try:
                            self.assertElementDoesNotExist('fieldset:nth-of-type(' + str(i) +') ul.choice_v.complete')
                            self.browser.find_element_by_css_selector('fieldset:nth-of-type(' + str(i) +') ul li label').click()
                        except AssertionError as e:
                            self.assertTrue(True)

                if que_type == "total_single_and_multiple_choice":
                    for i in range(1, numbr+1):
                        try:
                            element = self.browser.find_element_by_css_selector('fieldset:nth-of-type(' + str(i) +') ul input[type="checkbox"] + label')
                            element.click()
                        except Exception as e:
                            element = self.browser.find_element_by_css_selector('fieldset:nth-of-type(' + str(i) +') ul input[type="radio"] + label')
                            element.click()

                if que_type == "estimated_rank_type_questions":
                    for i in range(1, numbr+1):
                        try:
                            # choose the first option for each que
                            element = self.browser.find_element_by_css_selector('.fieldset-content:nth-of-type(' + str(i) +') > .align-labels input')
                            min_val = int(element.get_attribute("min"))
                            max_val = int(element.get_attribute("max"))

                            for j in range(min_val-1, max_val):
                                element = self.browser.find_elements_by_css_selector('.fieldset-content:nth-of-type(' + str(i) +') > .align-labels input')[j]
                                element.clear()
                                element.send_keys(str(j+1))

                        except NoSuchElementException as e:
                            self.assertTrue(True)

                if que_type == "multi_textbox_table":
                    for i in range(1, numbr+1):
                        # pass any valid input in the first input field of the que
                        try:
                            ele = self.browser.find_element_by_css_selector('tbody:nth-of-type(' + str(i) +') td .align-labels input')
                            ele.clear()
                            ele.send_keys('1')
                        except:
                            elements =  self.browser.find_elements_by_css_selector('.align-labels label + input')
                            for element in elements:
                                element.send_keys('1')

                if que_type == "int":
                    for i in range(0, numbr):
                        # pass any valid input in the first input field of the que
                        ele = self.browser.find_elements_by_css_selector('.align-labels label + input')[i]
                        ele.clear()
                        ele.send_keys('1')

                if que_type == "scale":
                    for i in range(1, numbr+1):
                        # choose the first option for each que
                        self.browser.find_element_by_css_selector('.scale:nth-of-type(' + str(i) +') input + label').click()

            else:
                if que_type == "multi_textbox_table":
                    for i in range(1, numbr+1):
                        # pass any invalid input in the first input field of the que
                        try:
                            ele = self.browser.find_element_by_css_selector('tbody:nth-of-type(' + str(i) +') td .align-labels input')
                            ele.clear()
                            ele.send_keys('-1')
                        except:
                            elements =  self.browser.find_elements_by_css_selector('.align-labels label + input')
                            for element in elements:
                                element.send_keys('-1')

                if que_type == "int":
                    for i in range(0, numbr):
                        # pass any invalid input in the first input field of the que
                        ele = (self.browser.find_elements_by_css_selector('.align-labels label + input')[i])
                        ele.clear()
                        ele.send_keys('-1')

                if que_type == "estimated_rank_type_questions":
                    for i in range(1, numbr+1):
                        try:
                            # choose the first option for each que
                            element = self.browser.find_element_by_css_selector('.fieldset-content:nth-of-type(' + str(i) +') > .align-labels input')
                            min_val = int(element.get_attribute("min"))
                            max_val = int(element.get_attribute("max"))

                            for j in range(min_val-1, max_val):
                                element = self.browser.find_elements_by_css_selector('.fieldset-content:nth-of-type(' + str(i) +') > .align-labels input')[j]
                                element.clear()
                                element.send_keys(str(min_val-1))

                        except NoSuchElementException as e:
                            self.assertTrue(True)

    def printErrorLog(self, test_name, err_msgs):
        index = 1
        print "======================================================================\nERROR LOG for "+test_name+"\n----------------------------------------------------------------------"
        for err in err_msgs:
            print "Error",index,": ",err
            index = index + 1
        print "----------------------------------------------------------------------"
    #assertions

    def assertIsDisabled(self, selector):
        self.assertEqual(self.browser.find_element_by_css_selector(selector).get_attribute('disabled'), 'true')

    def assertIsEnabled(self, selector):
        try:
            self.assertEqual(self.browser.find_element_by_css_selector(selector).get_attribute('disabled'), None)
        except AssertionError as e:
            self.assertEqual(self.browser.find_element_by_css_selector(selector).get_attribute('disabled'), 'false')

    def assertIsChecked(self, selector):
        self.assertTrue(self.browser.find_element_by_css_selector(selector).is_selected())

    def assertIsUnchecked(self, selector):
        self.assertFalse(self.browser.find_element_by_css_selector(selector).is_selected())

    def assertElementExists(self, selector):
        try:
            element = self.browser.find_element_by_css_selector(selector)
            self.assertTrue(element)
            return element
        except NoSuchElementException as e:
           self.fail("Could not find element with CSS selector '{}'".format(selector))

    def assertElementsExist(self, selector):
        try:
            element = self.browser.find_elements_by_css_selector(selector)
            self.assertTrue(element)
            return element
        except NoSuchElementException as e:
           self.fail("Could not find element with CSS selector '{}'".format(selector))

    def assertElementDoesNotExist(self, selector):
        try:
            element = self.browser.find_element_by_css_selector(selector)
            self.fail("Found an element with CSS selector '{}'".format(selector))
        except NoSuchElementException as e:
            self.assertTrue(True)

    def assertListSizeEquals(self, _list, size):
        self.assertEqual(len(_list), size)
