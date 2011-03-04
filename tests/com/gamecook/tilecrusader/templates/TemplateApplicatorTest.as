/*
 *
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included in
 *  all copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 *  THE SOFTWARE.
 * /
 */

/**
 * Created by IntelliJ IDEA.
 * User: Jesse Freeman
 * Date: 3/3/11
 * Time: 11:49 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.templates
{
    import com.gamecook.tilecrusader.enum.TemplateProperties;

    import org.flexunit.Assert;

    public class TemplateApplicatorTest extends TemplateApplicator
    {
        private var applicator:TemplateApplicator;

        public function TemplateApplicatorTest()
        {
        }

        [Test]
        public function getAttackOrDefensePropertyTest():void
        {
            Assert.assertEquals(TemplateProperties.ATTACK, getAttackOrDefenseProperty(0));
            Assert.assertEquals(TemplateProperties.ATTACK, getAttackOrDefenseProperty(.4));
            Assert.assertEquals(TemplateProperties.DEFENSE, getAttackOrDefenseProperty(.5));
            Assert.assertEquals(TemplateProperties.DEFENSE, getAttackOrDefenseProperty(.8));
        }

        [Test]
        public function getRandomPropertyPropertyTest():void
        {
            Assert.assertEquals(TemplateProperties.LIFE, getRandomProperty(0));
            Assert.assertEquals(TemplateProperties.ATTACK, getRandomProperty(1));
            Assert.assertEquals(TemplateProperties.DEFENSE, getRandomProperty(2));
        }
    }
}
