<script setup lang="ts">
import { onMounted, ref } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import liff from '@line/liff'

// Define the Profile type according to the structure returned by liff
interface Profile {
  displayName: string
  pictureUrl?: string // pictureUrl might be undefined
  statusMessage?: string // statusMessage might be undefined
  userId: string
}

const profile = ref<Profile | null>() // Use the Profile type or null

onMounted(async () => {
  try {
    await liff.init({ liffId: '2005904683-Gm7ggM5l' })

    // Check if the user is already logged in
    if (liff.isLoggedIn()) {
      const profileData = await liff.getProfile()
      const accessToken = liff.getAccessToken()
      console.log("LIFF COMPLETED with ", accessToken)
      console.log('Logged in user profile:', profileData)

      // Update the profile reference with the retrieved profile data
      profile.value = profileData
    } else {
      // Handle cases where the user is not logged in
      console.log('User not logged in')
    }
  } catch (err) {
    console.error('Error initializing LIFF:', err)
  }
})
</script>


<template>
  <div class="flex flex-col items-center justify-center min-h-screen bg-gray-100">
    <p v-if="profile">
      Hello<br>
      <span>{{ profile.displayName }}</span><br>
      <img :src="profile.pictureUrl" alt="Profile Picture" class="rounded-full"/>
    </p>
    <p v-else>
      Loading profile...
    </p>
  </div>
</template>

<style scoped>
/* Add any additional styles if needed */
img {
  width: 100px;
  height: 100px;
}
</style>
