import { defineEventHandler, readBody } from 'h3'
import jwt from 'jsonwebtoken'

const SECRET_KEY = 'your-secret-key'

export default defineEventHandler(async (event) => {
  const body = await readBody(event)

  const { id } = body

  // Simple validation (In real scenarios, use a database and hashing)
  if (id) {
    const token = jwt.sign({ id }, SECRET_KEY, { expiresIn: '1h' })
    // Create a token or session here
    console.log(token)
    return { success: true, message: token }
  } else {
    return { success: false, message: 'Invalid credentials' }
  }
})
    