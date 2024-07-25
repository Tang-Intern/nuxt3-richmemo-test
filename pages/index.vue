<script setup lang="ts">
import { onMounted, reactive } from 'vue'
import type { FormError, FormSubmitEvent } from '#ui/types'
import liff from '@line/liff';
import Line from './auths/line.vue'

const router = useRouter()

router.addRoute({ name: 'line', path: '/auths/line', component: Line })

const liffId = "2005904683-Gm7ggM5l";

onMounted(() => { 
  liff.init({
    liffId, // Use own liffId
  })
  });

const onSubmitbyLine = async (event: Event) => {
  event.preventDefault()
  console.log('line login')
  try {
    liff.login()
  } catch (err) {
    console.error(err)
  }
}

const state = reactive({
  email: undefined,
  password: undefined
})

const validate = (state: any): FormError[] => {
  const errors = []
  if (!state.email) errors.push({ path: 'email', message: 'Required' })
  if (!state.password) errors.push({ path: 'password', message: 'Required' })
  return errors
}

async function onSubmit(event: FormSubmitEvent<any>) {
  // Do something with data
  console.log(event.data)
}

</script>

<template>

  <div class="flex flex-col items-center justify-center align-items-center min-h-screen">
    <h1 class="pb-8 text-5xl font-bold ">
      Rich Memo
    </h1>

    <div class="p-2 w-auto h-auto flex flex-row border-2 rounded-lg">

      <div class="p-2 flex flex-col items-center justify-center border-r">
        <h1 class="p-5 text-5xl font-bold">
          Login
        </h1>
        <form @submit="onSubmitbyLine" class="space-y-4 bg-[#06C755] rounded-md p-2">
          <button type="submit" class="w-full text-white font-bold p-2 rounded">
            Login by Line
          </button>
        </form>
      </div>

      <div class="p-8 pr-10">
        <UForm :validate="validate" :state="state" class="space-y-4" @submit="onSubmit">
          <UFormGroup label="Email" name="email">
            <UInput v-model="state.email" />
          </UFormGroup>
          <UFormGroup label="Password" name="password">
            <UInput v-model="state.password" type="password" />
          </UFormGroup>

          <UButton type="submit">
            Submit
          </UButton>
        </UForm>
      </div>

    </div>
  </div>
  

</template>
