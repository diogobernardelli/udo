import store from '@/store'

const SUCCESS_ALERT = 'success'
const ERROR_ALERT = 'error'

export function displaySuccessAlert(message) {
	store.commit(
		'displayAlert',
		{
			message: message,
			status: SUCCESS_ALERT
		}
	)
}

export function displayErrorAlert(message) {
	store.commit(
		'displayAlert',
		{
			message: message,
			status: ERROR_ALERT
		}
	)
}