var assert = require('assert');

# mocha test/unit/learning-test.js
describe('Awaiting promises', function() {
    it('the basics', async () => {
        const promise = new Promise((resolve, reject) => {
            resolve('a');
        });

        const result = await promise;

        assert.equal('a', result);
    });
});
