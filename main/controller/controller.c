#include "controller.h"
#include "model/model.h"
#include "view/view.h"
#include "network/network.h"


void controller_init(model_t *pmodel) {
    network_init();
    // view_change_page(pmodel, &page_main);
}


void controller_process_message(model_t *pmodel, view_controller_message_t *msg) {
    switch (msg->code) {
        case VIEW_CONTROLLER_MESSAGE_CODE_NOTHING:
            break;
    }
}


void controller_manage(model_t *pmodel) {
    (void)pmodel;
}