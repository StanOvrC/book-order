package com.rsoi.controller;

import com.rsoi.service.OrderService;
import com.rsoi.service.UserService;
import com.rsoi.service.dto.order.CartActionDto;
import com.rsoi.service.dto.order.OrderDto;
import com.rsoi.service.dto.user.UserDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@RequiredArgsConstructor
@Controller
@RequestMapping("/cart")
public class OrderController {
    private final OrderService orderService;
    private final UserService userService;

    @GetMapping
    public String viewCart(Model model) {
        UserDto user = userService.getCurrentUser();
        OrderDto cart = orderService.getOrCreateCart(user);
        model.addAttribute("cart", cart);
        return "cart";
    }

    @PostMapping("/add")
    public String addToCart(@RequestParam("bookId") Long bookId,
                            @RequestParam(value = "quantity", defaultValue = "1") int quantity,
                            @RequestHeader(value = "Referer", required = false) String referer,
                            RedirectAttributes redirectAttributes) {
        try {
            UserDto user = userService.getCurrentUser();
            CartActionDto dto = new CartActionDto();
            dto.setBookId(bookId);
            dto.setQuantity(quantity);
            orderService.addItemToCart(user, dto);
            redirectAttributes.addFlashAttribute("successMessage", "Книга добавлена в корзину");
        } catch (Exception ex) {
            redirectAttributes.addFlashAttribute("errorMessage", ex.getMessage());
        }

        if (referer != null && !referer.isBlank()) {
            return "redirect:" + referer;
        }
        return "redirect:/cart";
    }

    @PostMapping("/decrease")
    public String decreaseQuantity(@RequestParam("bookId") Long bookId,
                                   @RequestParam(value = "quantity", defaultValue = "1") int quantity,
                                   RedirectAttributes redirectAttributes) {
        try {
            UserDto user = userService.getCurrentUser();
            CartActionDto dto = new CartActionDto();
            dto.setBookId(bookId);
            dto.setQuantity(quantity);
            orderService.decreaseItemQuantity(user, dto);
            redirectAttributes.addFlashAttribute("successMessage", "Количество обновлено");
        } catch (Exception ex) {
            redirectAttributes.addFlashAttribute("errorMessage", ex.getMessage());
        }
        return "redirect:/cart";
    }

    @PostMapping("/remove")
    public String removeItem(@RequestParam("orderItemId") Long orderItemId,
                             RedirectAttributes redirectAttributes) {
        try {
            UserDto user = userService.getCurrentUser();
            orderService.removeItemFromCart(user, orderItemId);
            redirectAttributes.addFlashAttribute("successMessage", "Позиция удалена из корзины");
        } catch (Exception ex) {
            redirectAttributes.addFlashAttribute("errorMessage", ex.getMessage());
        }
        return "redirect:/cart";
    }

    @PostMapping("/clear")
    public String clearCart(RedirectAttributes redirectAttributes) {
        try {
            UserDto user = userService.getCurrentUser();
            orderService.clearCart(user);
            redirectAttributes.addFlashAttribute("successMessage", "Корзина очищена");
        } catch (Exception ex) {
            redirectAttributes.addFlashAttribute("errorMessage", ex.getMessage());
        }
        return "redirect:/cart";
    }


    @PostMapping("/checkout")
    public String checkout(@RequestParam("address") String address,
                           RedirectAttributes redirectAttributes) {
        try {
            UserDto user = userService.getCurrentUser();
            OrderDto order = orderService.checkout(user, address);
            redirectAttributes.addFlashAttribute("successMessage", "Заказ оформлен");
            redirectAttributes.addFlashAttribute("createdOrder", order);
            return "redirect:/cart/success";
        } catch (Exception ex) {
            redirectAttributes.addFlashAttribute("errorMessage", ex.getMessage());
            return "redirect:/cart";
        }
    }

    @GetMapping("/checkout")
    public String showCheckoutPage(Model model) {
        UserDto user = userService.getCurrentUser();
        OrderDto cart = orderService.getOrCreateCart(user);
        model.addAttribute("cart", cart);
        return "checkout";
    }

    @GetMapping("/success")
    public String orderSuccess(RedirectAttributes redirectAttributes, Model model) {
        if (!model.containsAttribute("createdOrder")) {
            return "redirect:/books";
        }

        return "order-success";
    }
}
