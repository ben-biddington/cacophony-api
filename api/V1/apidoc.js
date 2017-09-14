/**
 * @apiDefine V1ResponseSuccess
 * @apiSuccess {Boolean} success If the request was successful.
 * @apiSuccess {String[]} messages Messages about the request.
 */

/**
 * @apiDefine V1ResponseError
 * @apiError {Boolean} success If the request was successful.
 * @apiError {String[]} messages Messages about the error.
 */

/**
 * @apiDefine V1UserAuthorizationHeader
 * @apiHeader {String} Authorization Signed JSON web token of a user.
 */
