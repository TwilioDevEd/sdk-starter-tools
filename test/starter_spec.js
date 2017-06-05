const frisby = require('frisby');

frisby.baseUrl('http://localhost:3001')

describe('SDK Starter Kit Test Suite', function () {
  it('should retrieve a token', function (done) {
    frisby.get('/token')
      .expect('status', 200)
      .done(done)
  })
  it('should retrieve the configuration check', function (done) {
    frisby.get('/config')
      .expect('status', 200)
      .done(done)
  })
  it('should be able to create a binding', function (done) {
    frisby.post('/register')
      .expect('status', 200)
      .done(done)
  })
  it('should be able to send a notification', function (done) {
    frisby.post('/send-notification')
      .expect('status', 200)
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
