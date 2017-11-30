from helpers.web_survey_helpers import *
from spec import *

import unittest, random
from ddt import ddt, data

def fillForm(self, caseIndex):
    # Question: entry
    value = cases[caseIndex]['entry']
    self.assertElementExists('input[value="'+value+'"] + label').click()
    # click Next
    self.assertElementExists('#action-next').click()
    self.waitForElementToAppear('input[value="PAGE_001"]')

    # Question: screened_past
    value = cases[caseIndex]['screened_past']
    self.assertElementExists('input[value="'+value+'"] + label').click()
    # click Next
    self.assertElementExists('#action-next').click()
    self.waitForElementToAppear('input[value="PAGE_003"]')

    # Question: age
    value = cases[caseIndex]['age']
    self.assertElementExists('#age').send_keys(value)
    # click Next
    self.assertElementExists('#action-next').click()
    self.waitForElementToAppear('input[value="PAGE_004"]')

    # Question: gender
    value = cases[caseIndex]['gender']
    self.assertElementExists('input[value="'+value+'"] + label').click()
    # click Next
    self.assertElementExists('#action-next').click()
    self.waitForElementToAppear('input[value="PAGE_004B"]')

    # Question: atsi and language
    atsi = cases[caseIndex]['atsi']
    self.assertElementExists('fieldset:nth-of-type(1) input[value="'+atsi+'"] + label').click()
    language = cases[caseIndex]['language']
    self.assertElementExists('fieldset:nth-of-type(2) input[value="'+language+'"] + label').click()
    # click Next
    self.assertElementExists('#action-next').click()
    self.waitForElementToAppear('input[value="PAGE_005"]')

    # Question: edu
    value = cases[caseIndex]['edu']
    self.assertElementExists('input[value="'+value+'"] + label').click()
    # click Next
    self.assertElementExists('#action-next').click()
    self.waitForElementToAppear('input[value="PAGE_005B"]')

    # Question: employment
    value = cases[caseIndex]['employment']
    self.assertElementExists('input[value="'+value+'"] + label').click()
    # click Next
    self.assertElementExists('#action-next').click()
    self.waitForElementToAppear('input[value="PAGE_005C"]')

    # Question: activity
    value = cases[caseIndex]['activity']
    self.assertElementExists('input[value="'+value+'"] + label').click()
    # click Next
    self.assertElementExists('#action-next').click()
    self.waitForElementToAppear('input[value="PAGE_005D"]')

    # Question: card
    value = cases[caseIndex]['card']
    self.assertElementExists('input[value="'+value+'"] + label').click()
    # click Next
    self.assertElementExists('#action-next').click()
    self.waitForElementToAppear('input[value="PAGE_006"]')

    # Question: phq1 and phq2
    phq1 = cases[caseIndex]['phq1']
    self.assertElementExists('fieldset:nth-of-type(1) input[value="'+phq1+'"] + label').click()
    phq2 = cases[caseIndex]['phq2']
    self.assertElementExists('fieldset:nth-of-type(2) input[value="'+phq2+'"] + label').click()
    # click Next
    self.assertElementExists('#action-next').click()
    self.waitForElementToAppear('input[value="PAGE_006B"]')

    # Question: gad1 and gad2
    gad1 = cases[caseIndex]['gad1']
    self.assertElementExists('fieldset:nth-of-type(1) input[value="'+gad1+'"] + label').click()
    gad2 = cases[caseIndex]['gad2']
    self.assertElementExists('fieldset:nth-of-type(2) input[value="'+gad2+'"] + label').click()
    # click Next
    self.assertElementExists('#action-next').click()
    self.waitForElementToAppear('input[value="PAGE_007"]')

    # Question: med
    value = cases[caseIndex]['med']
    self.assertElementExists('input[value="'+value+'"] + label').click()
    # click Next
    self.assertElementExists('#action-next').click()
    self.waitForElementToAppear('input[value="PAGE_invite_participate_1"]')


    # click Next
    self.assertElementExists('#action-next').click()
    self.waitForElementToAppear('input[value="PAGE_invite_participate_2"]')

    # click Next
    self.assertElementExists('#action-next').click()
    self.waitForElementToAppear('input[value="PAGE_invite_participate_3"]')

    # get started with Link-me (interested)
    self.assertElementExists('fieldset:nth-of-type(1) input[value="1"] + label').click()
    # click Next
    self.assertElementExists('#action-next').click()
    self.waitForElementToAppear('input[value="consent"]')


    # Fill form
    self.assertElementExists('#firstname').send_keys(cases[caseIndex]['firstname'])
    self.assertElementExists('#surname').send_keys(cases[caseIndex]['surname'])
    self.assertElementExists('.date input').send_keys('25')
    Select(self.assertElementExists('.date select')).select_by_visible_text('August')
    self.assertElementExists('.date select + input').send_keys('1991')
    self.assertElementExists('#email').send_keys('test_%s@test.com' % ''.join(random.choice(string.ascii_lowercase + string.digits) for _ in range(5)))
    self.assertElementExists('#phone').send_keys("0"+cases[caseIndex]['phone'])

    # click Next
    self.assertElementExists('#action-next').click()
    self.waitForElementToAppear('input[value="survey_start"]')

    # click Next
    self.assertElementExists('#action-next').click()
    self.waitForElementToAppear('input[value="PAGE_008"]')

    # Question: gp
    (Select(self.assertElementExists('label[for="gp"]+select'))).select_by_value(cases[caseIndex]['gp'])
    # Question: gp_reason
    value = cases[caseIndex]['gp_reason']
    self.assertElementExists('input[value="'+value+'"] + label').click()
    # click Next
    self.assertElementExists('#action-next').click()
    self.waitForElementToAppear('input[value="PAGE_008B"]')

    # Question: sf1_health and chronic
    value = cases[caseIndex]['sf1_health']
    self.assertElementExists('fieldset:nth-of-type(1) input[value="'+value+'"] + label').click()
    value = cases[caseIndex]['chronic']
    self.assertElementExists('fieldset:nth-of-type(2) input[value="'+value+'"] + label').click()
    # click Next
    self.assertElementExists('#action-next').click()
    self.waitForElementToAppear('input[value="PAGE_008C"]')

    # Question: live_alone and inc_mg
    value = cases[caseIndex]['live_alone']
    self.assertElementExists('fieldset:nth-of-type(1) input[value="'+value+'"] + label').click()
    value = cases[caseIndex]['inc_mg']
    self.assertElementExists('fieldset:nth-of-type(2) input[value="'+value+'"] + label').click()
    # click Next
    self.assertElementExists('#action-next').click()
    self.waitForElementToAppear('input[value="PAGE_009"]')

    # Question: phq3, phq4 and phq5
    value = cases[caseIndex]['phq3']
    self.assertElementExists('fieldset:nth-of-type(1) input[value="'+value+'"] + label').click()
    value = cases[caseIndex]['phq4']
    self.assertElementExists('fieldset:nth-of-type(2) input[value="'+value+'"] + label').click()
    value = cases[caseIndex]['phq5']
    self.assertElementExists('fieldset:nth-of-type(3) input[value="'+value+'"] + label').click()
    # click Next
    self.assertElementExists('#action-next').click()
    self.waitForElementToAppear('input[value="PAGE_009B"]')

    # Question: phq6 and phq7
    value = cases[caseIndex]['phq6']
    self.assertElementExists('fieldset:nth-of-type(1) input[value="'+value+'"] + label').click()
    value = cases[caseIndex]['phq7']
    self.assertElementExists('fieldset:nth-of-type(2) input[value="'+value+'"] + label').click()
    # click Next
    self.assertElementExists('#action-next').click()
    self.waitForElementToAppear('input[value="PAGE_009C"]')

    # Question: phq8 and phq9
    value = cases[caseIndex]['phq8']
    self.assertElementExists('fieldset:nth-of-type(1) input[value="'+value+'"] + label').click()
    value = cases[caseIndex]['phq9']
    self.assertElementExists('fieldset:nth-of-type(2) input[value="'+value+'"] + label').click()
    # click Next
    self.assertElementExists('#action-next').click()
    self.waitForElementToAppear('input[value="PAGE_010"]')

    # Question: ever_down and ever_nointerest
    value = cases[caseIndex]['ever_down']
    self.assertElementExists('fieldset:nth-of-type(1) input[value="'+value+'"] + label').click()
    value = cases[caseIndex]['ever_nointerest']
    self.assertElementExists('fieldset:nth-of-type(2) input[value="'+value+'"] + label').click()
    # click Next
    self.assertElementExists('#action-next').click()
    self.waitForElementToAppear('input[value="PAGE_011"]')

    # Question: gad3 and gad4
    value = cases[caseIndex]['gad3']
    self.assertElementExists('fieldset:nth-of-type(1) input[value="'+value+'"] + label').click()
    value = cases[caseIndex]['gad4']
    self.assertElementExists('fieldset:nth-of-type(2) input[value="'+value+'"] + label').click()
    # click Next
    self.assertElementExists('#action-next').click()
    self.waitForElementToAppear('input[value="PAGE_011B"]')

    # Question: gad5 and gad6
    value = cases[caseIndex]['gad5']
    self.assertElementExists('fieldset:nth-of-type(1) input[value="'+value+'"] + label').click()
    value = cases[caseIndex]['gad6']
    self.assertElementExists('fieldset:nth-of-type(2) input[value="'+value+'"] + label').click()
    # click Next
    self.assertElementExists('#action-next').click()
    self.waitForElementToAppear('input[value="PAGE_011C"]')

    # Question: gad7
    value = cases[caseIndex]['gad7']
    self.assertElementExists('input[value="'+value+'"] + label').click()
    # click Next
    self.assertElementExists('#action-next').click()
    time.sleep(1)

    # Question: eq1 and eq2
    value1 = cases[caseIndex]['eq1']
    if value1 != "" :
        self.assertElementExists('fieldset:nth-of-type(1) input[value="'+value1+'"] + label').click()
    value2 = cases[caseIndex]['eq2']
    if value2 != "" :
        self.assertElementExists('fieldset:nth-of-type(2) input[value="'+value2+'"] + label').click()
    # click Next
    self.assertElementExists('#action-next').click()
    time.sleep(1)

    # Question: eq3
    value = cases[caseIndex]['eq3']
    if value != "" :
        self.assertElementExists('input[value="'+value+'"] + label').click()
    # click Next
    self.assertElementExists('#action-next').click()
    time.sleep(1)

    # Question: eq4 and eq5
    value1 = cases[caseIndex]['eq4']
    if value1 != "" :
        self.assertElementExists('fieldset:nth-of-type(1) input[value="'+value1+'"] + label').click()
    value2 = cases[caseIndex]['eq5']
    if value2 != "" :
        self.assertElementExists('fieldset:nth-of-type(2) input[value="'+value2+'"] + label').click()
    # click Next
    self.assertElementExists('#action-next').click()
    time.sleep(1)

    # Question: healthrange
    value = cases[caseIndex]['healthrange']
    self.assertElementExists('#healthrange').send_keys(value)
    # click Next
    self.assertElementExists('#action-next').click()
    time.sleep(1)

    # Question: k1, k2 and k3
    value1 = cases[caseIndex]['k1']
    if value1 != "" :
        self.assertElementExists('fieldset:nth-of-type(1) input[value="'+value1+'"] + label').click()
    value2 = cases[caseIndex]['k2']
    if value2 != "" :
        self.assertElementExists('fieldset:nth-of-type(2) input[value="'+value2+'"] + label').click()
    value3 = cases[caseIndex]['k3']
    if value3 != "" :
        self.assertElementExists('fieldset:nth-of-type(3) input[value="'+value3+'"] + label').click()
    # click Next
    self.assertElementExists('#action-next').click()
    time.sleep(1)

    # Question: k4, k5 and k6
    value1 = cases[caseIndex]['k4']
    if value1 != "" :
        self.assertElementExists('fieldset:nth-of-type(1) input[value="'+value1+'"] + label').click()
    value2 = cases[caseIndex]['k5']
    if value2 != "" :
        self.assertElementExists('fieldset:nth-of-type(2) input[value="'+value2+'"] + label').click()
    value3 = cases[caseIndex]['k6']
    if value3 != "" :
        self.assertElementExists('fieldset:nth-of-type(3) input[value="'+value3+'"] + label').click()
    # click Next
    self.assertElementExists('#action-next').click()
    time.sleep(1)

    # Question: k7 and k8
    value1 = cases[caseIndex]['k7']
    if value1 != "" :
        self.assertElementExists('fieldset:nth-of-type(1) input[value="'+value1+'"] + label').click()
    value2 = cases[caseIndex]['k8']
    if value2 != "" :
        self.assertElementExists('fieldset:nth-of-type(2) input[value="'+value2+'"] + label').click()
    # click Next
    self.assertElementExists('#action-next').click()
    time.sleep(1)

    # Question: k9 and k10
    value1 = cases[caseIndex]['k9']
    if value1 != "" :
        self.assertElementExists('fieldset:nth-of-type(1) input[value="'+value1+'"] + label').click()
    value2 = cases[caseIndex]['k10']
    if value2 != "" :
        self.assertElementExists('fieldset:nth-of-type(2) input[value="'+value2+'"] + label').click()
    # click Next
    self.assertElementExists('#action-next').click()
    time.sleep(1)

    # Question: k11 and k12
    value1 = cases[caseIndex]['k11']
    if value1 != "" :
        self.assertElementExists('#k11').send_keys(value1)
    value2 = cases[caseIndex]['k12']
    if value2 != "" :
        self.assertElementExists('#k12').send_keys(value2)
    # click Next
    self.assertElementExists('#action-next').click()
    time.sleep(1)

    # Question: k13 and k14
    value1 = cases[caseIndex]['k13']
    if value1 != "" :
        self.assertElementExists('#k13').send_keys(value1)
    value2 = cases[caseIndex]['k14']
    if value2 != "" :
        self.assertElementExists('input[value="'+value2+'"] + label').click()
    # click Next
    self.assertElementExists('#action-next').click()
    time.sleep(1)

    try:
        self.assertElementExists('.row img')

        # click Next
        self.assertElementExists('#action-next').click()
        time.sleep(1)

        # click Next
        self.assertElementExists('#action-next').click()
        time.sleep(1)

        # Areas of difficult
        self.assertElementExists('input[type="checkbox"] + label').click()
        time.sleep(1)
        # click Next
        self.assertElementExists('#action-next').click()
        time.sleep(1)

        # Ans Next page (ans doent matter)
        self.assertElementExists('fieldset:nth-of-type(1) input[type="radio"] + label').click()
        self.assertElementExists('fieldset:nth-of-type(2) input[type="radio"] + label').click()
        time.sleep(1)
        # click Next
        self.assertElementExists('#action-next').click()
        time.sleep(1)

    except AssertionError as e:
        self.assertTrue(True)

@ddt
class TestCase(SeleniumBrowserTestCase, unittest.TestCase):

    def setUp(self):
        super(TestCase, self).setUpClass()
        self.authenticate(self.browser, username, password)

        # click on Create session button
        self.browser.find_element_by_css_selector('input[name="action.create_survey"]').click()
        time.sleep(1)

    def __init__(self, *args, **kwargs):
        super(TestCase, self).__init__(*args, **kwargs)

    # keep updating this as nything is added in data.csv file
    # @data(0)
    @data(0, 1, 2, 3, 4, 5, 6, 7, 8)
    def test(self, value):

        fillForm(self, value)

        err_msgs = []
        try:
            got = self.assertElementExists('#anxiety_predict').get_attribute('value')
            expected = cases[value]['anxiety_predict']
            self.assertEqual(got, expected)
        except AssertionError as e:
            err_msgs.append(str(e))

        try:
            got = self.assertElementExists('#depression_predict').get_attribute('value')
            expected = cases[value]['depression_predict']
            self.assertEqual(got, expected)
        except AssertionError as e:
            err_msgs.append(str(e))

        if len(err_msgs) > 0:
            self.printErrorLog("TestCase"+str(value), err_msgs)
            self.fail('Values got does not match the expected values')


    def tearDown(self):
        self.browser.quit()


if __name__ == "__main__":
    unittest.main()
