import router from '@/router'
import messages from '@/locales'
import { securedAxiosInstance } from '@/backend/axios'
import { displayErrorAlert } from '@/tools/display-alert-message'

export function signinSuccessful(response) {
	if (!response.data.csrf) {
		signinFailed(response)
		return
	}

	localStorage.username = response.data.username
	localStorage.csrf = response.data.csrf
	localStorage.alerts = response.data.alerts
	localStorage.signedIn = true

	router.replace('/list')
}

export function signinFailed(error) {
	errorAlert(error)
	
	delete localStorage.username
	delete localStorage.csrf
	delete localStorage.signedIn
	delete localStorage.alerts
}

export function checkSignedIn() {
	if (localStorage.signedIn) {
		router.replace('/list')
	}
}

export function checkSignedOut() {
	if (!localStorage.signedIn) {
		router.replace('/')
	}
}

export function signOut() {
	securedAxiosInstance.delete('/signin')
		.then(() => {
			delete localStorage.csrf
			delete localStorage.signedIn
			delete localStorage.alerts
			router.replace('/')
		})
		.catch(() => displayErrorAlert(messages.en.errors.cannot_sign_out))
}

export function errorAlert (error) {
	const errorMessage = (error.response && error.response.data && error.response.data.error) || error
	displayErrorAlert(errorMessage)
}