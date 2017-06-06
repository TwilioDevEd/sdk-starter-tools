const frisby = require('frisby')
const jwt_decode = require('jwt-decode')

var baseUrl = process.env.baseUrl || 'http://localhost:3000'

console.log('Using Base url: ' + baseUrl)

frisby.baseUrl(baseUrl)

describe('SDK Starter Kit Test Suite', function () {
  it('should retrieve a token', function (done) {
    frisby.get('/token')
      .then(function (response) {
        expect('status', 200)
        expect(response._body.identity).toBeDefined()
        expect(response._body.token).toBeDefined()
        tokenJson = jwt_decode(response._body.token)
        console.log(tokenJson)
        expect(tokenJson.grants.identity).toBeDefined()
        expect(tokenJson.grants.video).toBeDefined()
        expect(tokenJson.grants.ip_messaging).toBeDefined()
        expect(tokenJson.grants.ip_messaging.service_sid).toBeDefined()
        expect(tokenJson.grants.data_sync).toBeDefined()
        expect(tokenJson.grants.data_sync.service_sid).toBeDefined()
      })
      .done(done)
  })
  it('should retrieve the configuration check', function (done) {
    frisby.get('/config')
      .expect('status', 200)
      .done(done)
  })
  it('should be able to create a binding', function (done) {
    frisby.post('/register', {
      'identity':'testing',
      'BindingType':'gcm',
      'Address':'testing'
    }).expect('status', 200)
      .done(done)
  })
  it('should be able to send a notification', function (done) {
    frisby.post('/send-notification', {
      'identity':'testing'
    }).expect('status', 200)
      .done(done)
  })
  it('should retrieve home page', function (done) {
    frisby.get('/')
      .expect('status', 200)
      .done(done)
  })
  it('should retrieve Sync page', function (done) {
    frisby.get('/sync/')
      .expect('status', 200)
      .done(done)
  })
  it('should retrieve Chat page', function (done) {
    frisby.get('/chat/')
      .expect('status', 200)
      .done(done)
  })
  it('should retrieve Video page', function (done) {
    frisby.get('/video/')
      .expect('status', 200)
      .done(done)
  })
  it('should retrieve Notify page', function (done) {
    frisby.get('/notify/')
      .expect('status', 200)
      .done(done)
  })
})
