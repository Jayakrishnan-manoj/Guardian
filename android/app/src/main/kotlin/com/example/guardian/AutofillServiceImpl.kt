// package com.example.guardian

// import android.app.assist.AssistStructure
// import android.os.CancellationSignal
// import android.service.autofill.*
// import android.view.autofill.AutofillId
// import android.view.autofill.AutofillValue
// import android.widget.RemoteViews
// import android.content.IntentSender
// import android.app.PendingIntent
// import android.content.Intent
// import android.os.Build
// import android.view.View
// import androidx.annotation.RequiresApi

// @RequiresApi(api = Build.VERSION_CODES.O)
// class AutofillServiceImpl : AutofillService() {

//     override fun onFillRequest(
//     request: FillRequest,
//     cancellationSignal: CancellationSignal,
//     callback: FillCallback
//     ) {
//         val structure = request.fillContexts.last().structure

//     // Parse the structure to get autofillable fields (username, password)
//         val fields = parseStructure(structure)

//         if (fields.isEmpty()) {
//             callback.onSuccess(null)
//             return
//         }

//         val packageName = structure.activityComponent.packageName
//         val response = FillResponse.Builder()

//     // Iterate over the fields and add inline presentations
//         val dataSet = Dataset.Builder()
//         fields.forEach { field ->
//             // Inline suggestion presentation using custom layout
//             val inlinePresentation = InlinePresentation(
//                 RemoteViews(packageName, R.layout.inline_autofill_suggestion).apply {
//                     setTextViewText(
//                         android.R.id.textView, // Replace with the actual ID of your TextView in the custom layout
//                         if (field.type == FieldType.USERNAME) "Inline Username Suggestion" else "Inline Password Suggestion"
//                     )
//                     // Optionally set an icon or dynamic image for the ImageView
//                     setImageViewResource(R.id.imageView, R.drawable.launch_background) // Replace with actual ImageView ID
//                 },
//                 null,  // Alternate content for inline suggestions
//                 null   // Tooltip (optional)
//             )
        
//             // Set the inline presentation
//             dataSet.setInlinePresentation(
//                 field.id,
//                 inlinePresentation,
//                 inlinePresentation // Provide the same or alternate presentation for sensitive data
//             )
        
//             // Add autofill value
//             val autofillValue = when (field.type) {
//                 FieldType.USERNAME -> AutofillValue.forText("example_user")
//                 FieldType.PASSWORD -> AutofillValue.forText("example_password")
//             }
//             dataSet.setValue(
//                 field.id,
//                 autofillValue,
//                 RemoteViews(packageName, R.layout.inline_autofill_suggestion).apply {
//                     setTextViewText(
//                         android.R.id.text1,
//                         if (field.type == FieldType.USERNAME) "Username" else "Password"
//                     )
//                 }
//             )
//         }
        

//     // Add the dataset to the response
//         response.addDataset(dataSet.build())

//     // Send the autofill response
//         callback.onSuccess(response.build())
//     }

//     override fun onSaveRequest(request: SaveRequest, callback: SaveCallback) {
//         // Handle save request if needed
//         callback.onSuccess()
//     }

//     private fun parseStructure(structure: AssistStructure): List<AutofillField> {
//         val fields = mutableListOf<AutofillField>()
        
//         for (i in 0 until structure.windowNodeCount) {
//             val windowNode = structure.getWindowNodeAt(i)
//             parseNode(windowNode.rootViewNode, fields)
//         }
        
//         return fields
//     }

//     private fun parseNode(node: AssistStructure.ViewNode, fields: MutableList<AutofillField>) {
//         // Check if the node is an input field
//         val autofillHints = node.autofillHints
//         if (autofillHints != null) {
//             for (hint in autofillHints) {
//                 when (hint) {
//                     View.AUTOFILL_HINT_USERNAME,
//                     View.AUTOFILL_HINT_EMAIL_ADDRESS -> {
//                         fields.add(AutofillField(node.autofillId!!, FieldType.USERNAME, node.idEntry))
//                     }
//                     View.AUTOFILL_HINT_PASSWORD -> {
//                         fields.add(AutofillField(node.autofillId!!, FieldType.PASSWORD, node.idEntry))
//                     }
//                 }
//             }
//         }

//         // Recursively parse child nodes
//         for (i in 0 until node.childCount) {
//             parseNode(node.getChildAt(i), fields)
//         }
//     }

//     private fun getAuthenticationIntent(): PendingIntent {
//         val intent = Intent(this, MainActivity::class.java).apply {
//             action = "android.service.autofill.AutofillService"
//         }
        
//         return PendingIntent.getActivity(
//             this,
//             0,
//             intent,
//             PendingIntent.FLAG_ONE_SHOT or PendingIntent.FLAG_IMMUTABLE
//         )
//     }
// }

// data class AutofillField(
//     val id: AutofillId,
//     val type: FieldType,
//     val htmlId: String?
// )

// enum class FieldType {
//     USERNAME,
//     PASSWORD
// } 