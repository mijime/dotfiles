package main

type errorResponse struct {
	Ok           bool   `json:"ok"`
	ErrorMessage string `json:"error"`
	Needed       string `json:"needed"`
}

func (r errorResponse) Error() string {
	msg := r.ErrorMessage

	if len(r.Needed) > 0 {
		msg += ", needed: " + r.Needed
	}

	return msg
}
