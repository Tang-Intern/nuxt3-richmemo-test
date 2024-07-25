<script setup lang="ts">
import { onMounted, ref } from 'vue'
import liff from '@line/liff'
import axios from 'axios'

// Define the Profile type according to the structure returned by liff
interface Profile {
  userId: string
  displayName?: string
  pictureUrl?: string // pictureUrl might be undefined
  statusMessage?: string // statusMessage might be undefined
}

const profile = ref<Profile | null>() // Use the Profile type or null
const router = useRouter()
const token = useCookie('token')

onMounted(async () => {
  try {
    await liff.init({ liffId: '2005904683-Gm7ggM5l' })
    
    // Check if the user is already logged in
    if (liff.isLoggedIn()) {
      const profileData = await liff.getProfile()
      const accessToken = liff.getAccessToken()
      const idToken = liff.getIDToken();
      console.log("LIFF COMPLETED with ", idToken); // print raw idToken object
      console.log("Access Token: ", accessToken)
      console.log('Logged in user profile:', profileData)
      profile.value = profileData

      const response = await fetch('/api/login', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ id: idToken }),
      })

      if (response.ok) {
      const data = await response.json()
      // Handle login success, e.g., redirect or store token
      // console.error('Login succeeded')
    } else {
      // Handle login error
      console.error('Login failed')
      router.push("/")
    }
      // Update the profile reference with the retrieved profile data
      
    } else {
      // Handle cases where the user is not logged in
      console.log('User not logged in')
      router.push("/")
    }
  } catch (err) {
    console.error('Error initializing LIFF:', err)
  }
})

const logout = () => {
  liff.logout()
  token.value = null
  window.location.href = '/' // Redirect to root directory
}

</script>

<template>
  <div class="flex flex-col items-center justify-center min-h-screen bg-gray-100">
    <p v-if="profile" class="flex flex-col items-center ">
      <div class="font-bold text-5xl p-8"> Welcome To Richmemo </div><br>
      <span>{{ profile.displayName }}</span><br>
      <img :src="profile.pictureUrl" alt="Profile Picture" class="rounded-full h-10 w-10"/>
    </p>
    <p v-else>
      Loading profile...
    </p>

    <button @click="logout" class="mt-10 p-2 bg-blue-500 text-white rounded">Logout</button>

  </div>
</template>
