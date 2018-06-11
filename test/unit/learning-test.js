var assert = require('assert');

// mocha test/unit/learning-test.js
describe('Awaiting promises', function() {
    it('the basics', async () => {
        const promise = new Promise((resolve, reject) => {
            resolve('a');
        });

        const result = await promise;

        assert.equal('a', result);
    });
});

const config = require('../../config');

console.log(config);

//@todo: forced to do this as `Server.js` does.
//@todo: path nonsense
config.loadConfig('../../sauce/cacophony-api/config/app.js');

var util = require("../../api/V1/util");

// mocha test/unit/learning-test.js
describe('file upload', function() {
    it.only('the basics', async () => {
        const fun = util.multipartDownload('file', {});

        // impossible to know what args are supposed to look like
        const result = await fun(
            {
                'part'
            },
            {});
    });
});
